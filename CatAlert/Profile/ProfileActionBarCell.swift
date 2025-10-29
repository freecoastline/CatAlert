//
//  ProfileActionBarCell.swift
//  CatAlert
//
//  Created by ken on 2025/10/29.
//

import UIKit

class ProfileActionBarCell: UICollectionViewCell {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponent
    private var actionBar = ProfileActionBar(frame: .zero)
    
    // MARK: - Setup
    private func setupUI() {
        contentView.addSubview(actionBar)
        actionBar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
