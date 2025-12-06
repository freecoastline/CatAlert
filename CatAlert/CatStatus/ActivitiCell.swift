//
//  ActivityCell.swift
//  CatAlert
//
//  Created by ken on 2025/12/6.
//

import Foundation
import UIKit

class ActivitiCell: UICollectionViewCell {
    // MARK: - Static
    static let identifier = "ActivitiCell"
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        
    }
}
