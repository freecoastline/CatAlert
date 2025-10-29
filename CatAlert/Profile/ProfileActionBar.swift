//
//  ProfileActionBar.swift
//  CatAlert
//
//  Created by ken on 2025/10/27.
//

import Foundation
import UIKit

class ProfileActionBar: UIView {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Enum
    enum Tab: Int {
        case album = 0
        case favorite = 1
        case like = 2
        var title: String {
            switch self {
            case .album:
                return "相册"
            case .favorite:
                return "收藏"
            case .like:
                return "喜欢"
            }
        }
    }
    
    // MARK: - Properties
    var onTabChanged: ((Tab) -> Void)?
    var currentTab: Tab = .album {
        didSet {
            updateButtonState()
            moveIndicator(to: currentTab)
            onTabChanged?(currentTab)
        }
    }
    
    // MARK: - Setup
    private func setupUI() {
        addSubview(stackView)
        addSubview(indicator)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        indicator.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalTo(albumButton)
            make.height.equalTo(3)
            make.width.equalTo(20)
        }
        
        updateButtonState()
    }
    
    
    // MARK: - Actions
    @objc private func tabButtonTapped(_ sender: UIButton) {
        guard let tab = Tab(rawValue: sender.tag) else {
            return
        }
        currentTab = tab
    }
    
    // MARK: - Helper
    private func updateButtonState() {
        let selectorColor = UIColor.black
        let normalColor = UIColor.gray
        
        albumButton.setTitleColor(currentTab == .album ? selectorColor : normalColor, for: .normal)
        favoriteButton.setTitleColor(currentTab == .favorite ? selectorColor : normalColor, for: .normal)
        likeButton.setTitleColor(currentTab == .like ? selectorColor : normalColor, for: .normal)
    }
    
    private func moveIndicator(to tab: Tab) {
        let targetButton: UIButton
        switch tab {
        case .album:
            targetButton = albumButton
        case .favorite:
            targetButton = favoriteButton
        case .like:
            targetButton = likeButton
        }
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            indicator.snp.remakeConstraints { make in
                make.centerX.equalTo(targetButton)
                make.height.equalTo(3)
                make.width.equalTo(20)
                make.bottom.equalToSuperview()
            }
            layoutIfNeeded()
        }
    }
    
    // MARK: - UI Components
    private lazy var albumButton: UIButton = {
        let button = UIButton(type: .system)
        button.tag = Tab.album.rawValue
        button.setTitle(Tab.album.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Tab.favorite.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.tag = Tab.favorite.rawValue
        button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Tab.like.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.tag = Tab.like.rawValue
        button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [albumButton, favoriteButton, likeButton])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var indicator: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 1.5
        view.backgroundColor = .black
        return view
    }()

    
}

