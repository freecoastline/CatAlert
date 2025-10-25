//
//  ProfileVideoCell.swift
//  CatAlert
//
//  Created by ken on 2025/10/25.
//

import UIKit

class ProfileVideoCell: UICollectionViewCell {
    // MARK: - UI Components
    private lazy var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private lazy var playIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "play.fill")
        view.contentMode = .scaleAspectFit
        view.tintColor = .white
        return view
    }()
    
    private lazy var playCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .white
        label.textAlignment = .natural
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
        
        thumbnailImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        playIcon.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(8)
            make.width.height.equalTo(12)
        }
        
        playCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(playIcon.snp.trailing).offset(6)
            make.centerY.equalTo(playIcon)
        }
    }
    
    
}
