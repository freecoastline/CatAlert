//
//  ChatViewController.swift
//  CatAlert
//
//  Created by ken on 2025/11/23.
//

import Foundation
import UIKit
import SnapKit

class ChatViewController: UIViewController {
    // MARK: - Property
    private var messages: [ChatMessage] = []
    private var inputContainerBottonConstraint: Constraint?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerKeyboardNotification()
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Pet Consultation"
        view.addSubview(tableView)
        view.addSubview(inputContainerView)
        inputContainerView.addSubview(inputTextField)
        inputContainerView.addSubview(sendButton)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(inputContainerView.snp.top)
        }
        
        inputContainerView.snp.makeConstraints { [weak self] make in
            guard let self else { return }
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview()
            inputContainerBottonConstraint =  make.bottom.equalTo(view.safeAreaLayoutGuide).constraint
        }
        
        inputTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        sendButton.snp.makeConstraints { make in
            make.leading.equalTo(inputTextField.snp.trailing).offset(10)
            make.width.equalTo(60)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Observer
    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillshow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillhide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(sendCodeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Action
    @objc private func keyboardWillshow() {
        
    }
    
    @objc private func keyboardWillhide() {
        
    }
    
    @objc private func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func sendCodeButtonTapped() {
        guard let text = inputTextField.text?.trimmingCharacters(in: .whitespaces),
              !text.isEmpty else {
            return
        }
        let message = ChatMessage(content: text, role: .user)
        messages.append(message)
        inputTextField.text = ""
        sendButton.isEnabled = false
        tableView.reloadData()
        scrollToBottom()
    }
    
    private func scrollToBottom() {
        guard messages.count > 0 else {
            return
        }
        let lastIndex = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
    }
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
