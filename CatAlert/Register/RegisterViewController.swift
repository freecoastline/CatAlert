//
//  RegisterViewController.swift
//  CatAlert
//
//  Created by ken on 2025/11/14.
//

import Foundation
import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    // MARK: - Init
    deinit {
        stopCountdown()
    }
    
    // MARK: - UI component
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入用户名"
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 16)
        textField.keyboardType = .default
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入邮箱"
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 16)
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入密码"
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 16)
        textField.keyboardType = .default
        return textField
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "欢迎注册 CatAlert"
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
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("注册", for: .normal)
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
    
    private lazy var jumpToLoginPageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .blue
        button.setTitle("跳转登陆页", for: .normal)
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
        setupKeyboardDismissal()
    }
    
    // MARK: - Action
    @objc private func jumpToLoginPageButtonTapped() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc private func registerButtonTapped() {
        guard let phone = phoneTextField.text, !phone.isEmpty else {
            showAlert("号码无效")
            return
        }
        
        guard let code = codeTextField.text, !code.isEmpty else {
            showAlert("验证码无效")
            return
        }
        
        guard let username = usernameTextField.text, let password = passwordField.text, let email = emailTextField.text else {
            showAlert("user Info Invalid")
            return
        }
        
        Task {
            do {
                try await AuthManager.shared.register(username: username, password: password, email: email)
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
    
    // MARK: - Input Accessory
    private func createKeyboardToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [flexible, doneButton]
        
        return toolbar
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        print("1️⃣ dismmissKeyboard")
    }
    
    // MARK: - SetupUI
    private func setupKeyboardDismissal() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("1️⃣ Custom view: touchesBegan")
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("1️⃣ Custom view: touchesend")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("1️⃣ Custom view: touchescancelled")
    }
    
    private func setupUI() {
        setupViewHierarchy()
        setupConstraints()
        setupKeyboardToolbars()
        setupActions()
    }
    
    private func setupActions() {
        sendCodeButton.addTarget(self, action: #selector(sendCodeButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        jumpToLoginPageButton.addTarget(self, action: #selector(jumpToLoginPageButtonTapped), for: .touchUpInside)
    }
    
    private func setupKeyboardToolbars() {
        let toolbar = createKeyboardToolbar()
        phoneTextField.inputAccessoryView = toolbar
        codeTextField.inputAccessoryView = toolbar
        passwordField.inputAccessoryView = toolbar
        emailTextField.inputAccessoryView = toolbar
        usernameTextField.inputAccessoryView = toolbar
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        jumpToLoginPageButton.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
    private func setupViewHierarchy() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordField)
        view.addSubview(emailTextField)
        view.addSubview(registerButton)
        view.addSubview(jumpToLoginPageButton)
        isModalInPresentation = true
    }
}
