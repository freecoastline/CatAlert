//
//  ProfileHeaderCell.swift
//  CatAlert
//
//  Created by ken on 2025/10/22.
//

import UIKit

class ProfileHeaderCell: UICollectionViewCell {
    // MARK: UI components
    private lazy var avatarImageView:UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemGray5
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return nameLabel
    }()
    
    private lazy var handleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return handleLabel
    }()
    
    private lazy var followingCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followingTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followingStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [followingCountLabel, followingCountLabel])
        stack.axis = .vertical
        stack.spacing = 5.0
        stack.alignment = .center
        return stack
    }()
    
    private lazy var followerCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [followerCountLabel, followerTitleLabel])
        stack.axis = .vertical
        stack.spacing = 5.0
        stack.alignment = .center
        return stack
    }()
    
    private lazy var likesCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var likesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var likesStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [likesCountLabel, likesTitleLabel])
        stack.axis = .vertical
        stack.spacing = 5.0
        stack.alignment = .center
        return stack
    }()
    
    private lazy var statsView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [followingStackView, followerStackView, likesStackView])
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.axis = .horizontal
        return stack
    }()
    
    // MARK: Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setupUI() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(handleLabel)
        contentView.addSubview(statsView)
    }
    
    // MARK: Public Methods
    
}
