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
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()
    
    private lazy var saveButton = {
        let item = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveButtonTapped))
        return item
    }()
    
    
    @objc private func saveButtonTapped() {
        
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
        return UITableViewCell()
    }
    
}
