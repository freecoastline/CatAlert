//
//  LoginViewController.swift
//  CatAlert
//
//  Created by ken on 2025/11/14.
//

import Foundation
import UIKit
import SnapKit

class LoginViewController: UIViewController {
    // MARK: - Init
    deinit {
        stopCountdown()
    }
    
    // MARK: - UI component
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "欢迎使用 CatAlert"
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = "请输入手机号"
        textFiled.keyboardType = .numberPad
        textFiled.borderStyle = .roundedRect
        textFiled.font = .systemFont(ofSize: 16)
        textFiled.clearButtonMode = .whileEditing
        return textFiled
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("登陆", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var codeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入验证码"
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 16)
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var sendCodeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .blue
        button.setTitle("发送验证码", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    // MARK: - Property
    private var countdownTimer: Timer?
    private var countdown:Int = 60
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Action
    @objc private func loginButtonTapped() {
        guard let phone = phoneTextField.text, !phone.isEmpty else {
            showAlert("号码无效")
            return
        }
        
        guard let code = codeTextField.text, !code.isEmpty else {
            showAlert("验证码无效")
            return
        }
        
        Task {
            do {
                try await AuthManager.shared.login(phone: phone, code: code)
                await MainActor.run {
                    dismiss(animated: true)
                }
            } catch {
                let message = (error as? AuthError)?.localizedDescription ?? "登陆失败"
                showAlert(message)
            }
        }
    }
    
    @objc private func sendCodeButtonTapped() {
        guard let phone = phoneTextField.text, !phone.isEmpty else {
            showAlert("号码无效")
            return
        }
        
        Task {
            do {
                try await AuthManager.shared.sendVerificationCode(phone: phone)
                showAlert("验证码发送成功")
                startCountdown()
            } catch {
                let message = (error as? AuthError)?.localizedDescription ?? "发送失败"
                showAlert(message)
            }
        }
    }
    
    // MARK: - Helper Method
    @MainActor
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        present(alert, animated: true)
    }
    
    private func startCountdown() {
        countdown = 60
        sendCodeButton.isEnabled = false
        sendCodeButton.backgroundColor = .gray
        sendCodeButton.setTitle("\(countdown)秒后发送验证码", for: .normal)  // ← 添加这行
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    private func stopCountdown() {
        sendCodeButton.isEnabled = true
        sendCodeButton.backgroundColor = .blue
        countdownTimer?.invalidate()
        countdownTimer = nil
        sendCodeButton.setTitle("发送验证码", for: .normal)
    }
    
    @objc private func updateTimer() {
        countdown -= 1
        if countdown >= 1 {
            sendCodeButton.setTitle("\(countdown)秒后发送验证码", for: .normal)
        } else {
            stopCountdown()
        }
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(phoneTextField)
        view.addSubview(sendCodeButton)
        view.addSubview(codeTextField)
        view.addSubview(loginButton)
        isModalInPresentation = true
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        sendCodeButton.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(sendCodeButton.snp.top)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(sendCodeButton.snp.leading).offset(-20)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        sendCodeButton.addTarget(self, action: #selector(sendCodeButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
    }
}
