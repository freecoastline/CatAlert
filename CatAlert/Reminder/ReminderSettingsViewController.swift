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
    private var allReminders:[CatReminder] = []
    
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
            }.store(in: &cancellables)
    }
    
    private func reminder(for section: Int) -> [CatReminder] {
        let type:CatCareType = {
            switch section {
            case 0:
                    .food
            case 1:
                    .water
            case 2:
                    .play
            default:
                    .play
            }
        }()
        let reminders = allReminders.filter { $0.type == type }
        return reminders
    }
    
    private func reminder(for indexPath: IndexPath) -> CatReminder {
        let reminders = reminder(for: indexPath.section)
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
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
