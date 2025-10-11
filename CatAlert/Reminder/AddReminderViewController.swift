//
//  AddReminderViewController.swift
//  CatAlert
//
//  Created by ken on 2025/9/26.
//

import Foundation
import UIKit

class AddReminderViewController:UIViewController, UITableViewDelegate {
    enum FormSection:Int {
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
    private var reminderTitle:String = ""
    private var reminderType:CatCareType = .food
    private var reminderTimes:[ReminderTime] = []
    private var reminderFrequency:ReminderFrequency = .daily
    
    // MARK: - UI Components
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(TextFieldCell.self, forCellReuseIdentifier: "TextFieldCell")
        table.delegate = self
        table.dataSource = self
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
    }
}


extension AddReminderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
