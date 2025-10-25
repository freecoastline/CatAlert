//
//  ProfileVideoCell.swift
//  CatAlert
//
//  Created by ken on 2025/10/25.
//

import UIKit

class ProfileVideoCell: UICollectionViewCell {
    // MARK: - UI Components
    private var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private var playIcon: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private var playCountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
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
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(playIcon)
        contentView.addSubview(playCountLabel)
        
    }
    
    
}
