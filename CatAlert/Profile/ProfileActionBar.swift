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
    var tabTapped: ((Tab) -> Void)?
    var currentTab: Tab = .album {
        didSet {
            
        }
    }
    
    // MARK: - Setup
    private func setupUI() {
        
    }
    
    
    
}
