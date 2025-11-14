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
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("登陆", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.backgroundColor = .red
        return button
    }()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        
    }
}
