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
        
    }
    
    
    // MARK: - Actions
    @objc private func tabButtonTapped(_ sender: UIButton) {
        
    }
    
    // MARK: - Helper
    private func updateButtonState() {
        
    }
    
    private func moveIndicator(to tab: Tab) {
        
    }
    
    // MARK: - UI Components
    private lazy var albumButton: UIButton = {
        let button = UIButton()
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
    
}
