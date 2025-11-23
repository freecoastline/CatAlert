//
//  ChatViewController.swift
//  CatAlert
//
//  Created by ken on 2025/11/23.
//

import Foundation
import UIKit

class ChatViewController: UIViewController {
    // MARK: - Property
    private var messages: [ChatMessage] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UI Components
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.register(MessageCell.self, forCellReuseIdentifier: "MessageCell")
        view.backgroundColor = .systemBackground
        return view
    }()
}

extension ChatViewController: UITableViewDelegate {
    
}


extension ChatViewController: UITableViewDataSource {
    
}
