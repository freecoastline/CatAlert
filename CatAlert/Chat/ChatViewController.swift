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
        setupUI()
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Pet Consultation"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
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
    
    private lazy var inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private lazy var inputTextField: UITextField = {
        let input = UITextField()
        input.placeholder = "Type a message..."
        input.borderStyle = .roundedRect
        input.font = .systemFont(ofSize: 16)
        input.backgroundColor = .systemBackground
        return input
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.isEnabled = false
        return button
    }()
}

extension ChatViewController: UITableViewDelegate {
    
}


extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? MessageCell else {
            #if DEBUG
            print("❌ ERROR: Could not cast to MessageCell!")
            #endif
            return UITableViewCell()
        }
        let message = messages[indexPath.row]
        cell.configure(with: message)
        return cell
    }
    
    
}
