//
//  ReminderSettingsViewController.swift
//  CatAlert
//
//  Created by ken on 2025/9/26.
//

import Foundation
import UIKit
import Combine

class ReminderSettingsViewController:UIViewController, UITableViewDelegate {
    private lazy var tableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.register(ReminderCell.self, forCellReuseIdentifier: "ReminderCell")
        return table
    }()
    
    private var cancellables = Set<AnyCancellable>()
    private var allReminders: [CatReminder] = []
    private let sectionTypes: [CatCareType] = [.food, .water, .play]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allReminders = ReminderManager.shared.activeReminders
        setupNavigationBar()
        setupUI()
        observeDataChange()
    }
    
    private func observeDataChange() {
        ReminderManager.shared.$activeReminders
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newAllReminders in
                guard let self else {
                    return
                }
                allReminders = newAllReminders
                tableView.reloadData()
            }.store(in: &cancellables)
    }
    
    private func reminders(for section: Int) -> [CatReminder] {
        let type = sectionTypes[section]
        let reminders = allReminders.filter { $0.type == type }
        return reminders
    }
    
    private func reminder(at indexPath: IndexPath) -> CatReminder? {
        let reminders = reminders(for: indexPath.section)
        guard indexPath.row < reminders.count else {
            return nil
        }
        return reminders[indexPath.row]
    }
    
    private func setupNavigationBar() {
        // 设置标题
        title = "提醒设置"

        // 添加右侧 + 按钮
        let addButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.rightBarButtonItem = addButton
    }

    @objc private func addButtonTapped() {
        let addVC = AddReminderViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.bottom.right.equalToSuperview()
        }
    }
}


extension ReminderSettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders(for: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell") as? ReminderCell, let reminder = reminder(at: indexPath) else {
            return UITableViewCell()
        }
        cell.configure(with: reminder)
        return cell
    }
}
