//
//  ReminderSettingsViewController.swift
//  CatAlert
//
//  Created by ken on 2025/9/26.
//

import Foundation
import UIKit

class ReminderSettingsViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
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
        view.backgroundColor = UIColor(red: 0xF2/255.0, green: 0xF2/255.0, blue: 0xF7/255.0, alpha: 1.0)
    }
}
