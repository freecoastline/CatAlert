//
//  AddReminderViewController.swift
//  CatAlert
//
//  Created by ken on 2025/9/26.
//

import Foundation
import UIKit

class AddReminderViewController: UIViewController, UITableViewDelegate {
    enum FormSection: Int {
        case basic = 0
        case times = 1
        var title:String {
            switch self {
            case .basic:
                "基本信息"
            case .times:
                "提醒时间"
            }
        }
        
    }
    // MARK: - Models
    private var reminderTitle: String = ""
    private var reminderType: CatCareType = .food
    private var reminderTimes: [ReminderTime] = []
    private var reminderFrequency: ReminderFrequency = .daily
    
    // MARK: - UI Components
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(TextFieldCell.self, forCellReuseIdentifier: "TextFieldCell")
        table.register(SelectionCell.self, forCellReuseIdentifier: "SelectionCell")
        table.register(TimeCell.self, forCellReuseIdentifier: "TimeCell")
        table.register(AddButtonCell.self, forCellReuseIdentifier: "AddButtonCell")
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()
    
    private lazy var saveButton = {
        let item = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveButtonTapped))
        item.isEnabled = false
        return item
    }()
    
    private func updateSaveButtonState() {
        saveButton.isEnabled = isFormValid()
    }
    
    private func isFormValid() -> Bool {
        // 标题不能为空
        guard !reminderTitle.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }

        // 至少需要一个提醒时间
        guard !reminderTimes.isEmpty else {
            return false
        }

        return true
    }
    
    
    @objc private func saveButtonTapped() {
        guard isFormValid() else {
            showAlert("表单信息有误，请重新填写")
            return
        }
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    private func showTypeSelector() {
        let alert = UIAlertController(title: "选择类型", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "喂食", style: .default, handler: { [weak self] action in
            guard let self else {
                return
            }
            reminderType = .food
            tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        }))
        
        alert.addAction(UIAlertAction(title: "喂水", style: .default, handler: { [weak self] action in
            guard let self else {
                return
            }
            reminderType = .water
            tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        }))

        alert.addAction(UIAlertAction(title: "玩耍", style: .default, handler: { [weak self] action in
            guard let self else {
                return
            }
            reminderType = .play
            tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        }))
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        present(alert, animated: true)
    }
    
    private func showFrequencySelector() {
        let alert = UIAlertController(title: "选择频率", message: nil, preferredStyle: .actionSheet)
        
        let frequencyItems: [(title: String, frequency: ReminderFrequency)] = [
            ("每天", .daily),
            ("每周", .weekly)
        ]
        
        frequencyItems.forEach { title, frequency in
            alert.addAction(UIAlertAction(title: title, style: .default, handler: { [weak self] _ in
                guard let self else {
                    return
                }
                reminderFrequency = frequency
                tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
            }))
        }

        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "新建提醒"
        navigationItem.rightBarButtonItem = saveButton
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


extension AddReminderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return FormSection(rawValue: section)?.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch FormSection(rawValue: section) {
        case .basic:
            return 3
        case .times:
            return reminderTimes.count + 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch FormSection(rawValue: indexPath.section) {
        case .basic:
            switch indexPath.row {
            case 1: showTypeSelector()
            case 2: showFrequencySelector()
            default: break
            }
        case .times:
            let timePicker = TimePickerViewController()
            if indexPath.row < reminderTimes.count {
                timePicker.initialHour = reminderTimes[indexPath.row].hour
                timePicker.initialMinute = reminderTimes[indexPath.row].minute
                timePicker.onTimeSelected = { [weak self] reminderTime in
                    guard let self else {
                        return
                    }
                    reminderTimes[indexPath.row] = reminderTime
                }
                tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
            }
            navigationController?.pushViewController(timePicker, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch FormSection(rawValue: indexPath.section) {
        case .basic:
            return cellForBasicSection(at: indexPath)
        case .times:
            return cellForTimeSection(at: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard FormSection(rawValue: indexPath.section) == .times,
              indexPath.row < reminderTimes.count,
              editingStyle == .delete else {
            return
        }
        
        reminderTimes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        updateSaveButtonState()
    }
    
    private func cellForBasicSection(at indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as? TextFieldCell else {
                return UITableViewCell()
            }
            cell.onTextChanged = {[weak self] str in
                guard let self else {
                    return
                }
                updateSaveButtonState()
                reminderTitle = str
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionCell") as? SelectionCell else {
                return UITableViewCell()
            }
            cell.configure(
                icon: "🏷️",
                title: "类型",
                value: reminderType.displayname
            )
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionCell") as? SelectionCell else {
                return UITableViewCell()
            }
            cell.configure(
                icon: "🔁",
                title: "频率",
                value: reminderFrequency.displayname
            )
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    private func cellForTimeSection(at indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == reminderTimes.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonCell") as? AddButtonCell else {
                return UITableViewCell()
            }
            cell.onTapAdd = { [weak self] in
                guard let self else {
                    return
                }
                let timePickVC = TimePickerViewController()
                timePickVC.onTimeSelected = { [weak self] reminderTime in
                    guard let self else {
                        return
                    }
                    if reminderTimes.contains(where: { $0.hour == reminderTime.hour && $0.minute == reminderTime.minute }) {
                        showAlert("该时间已存在")
                        return
                    }
                    reminderTimes.append(reminderTime)
                    tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
                }
                navigationController?.pushViewController(timePickVC, animated: true)
            }
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell") as? TimeCell else {
            return UITableViewCell()
        }
        let indexString = "时间 \(indexPath.row + 1)"
        let timeString = reminderTimes[indexPath.row].displayTime
        cell.configure(indexString: indexString, timeString: timeString)
        return cell
    }
    
}
