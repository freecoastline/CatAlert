//
//  PhotoEditViewController.swift
//  CatAlert
//
//  Created by ken on 2025/12/31.
//

import Foundation
import UIKit

class PhotoEditViewController: UIViewController {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupBackButton()
        setupNextButton()
    }
    
    private func setupBackButton() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(UIConstants.PhotoEdit.navigationPadding)
            make.leading.equalToSuperview().offset(UIConstants.PhotoEdit.navigationPadding)
            make.height.width.equalTo(UIConstants.PhotoEdit.backButtonSize)
        }
    }
    
    private func setupNextButton() {
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(UIConstants.PhotoEdit.navigationPadding)
            make.trailing.equalToSuperview().offset(-UIConstants.PhotoEdit.navigationPadding)
        }
    }
    
    // MARK: - Properties
    private let originalImage: UIImage
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView(image: originalImage)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .black
        return iv
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: UIConstants.PhotoEdit.nextButtonFontSize, weight: .semibold)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(originalImage: UIImage) {
        self.originalImage = originalImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func nextButtonTapped() {
        
    }
}
