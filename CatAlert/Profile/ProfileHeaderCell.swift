//
//  ProfileHeaderCell.swift
//  CatAlert
//
//  Created by ken on 2025/10/22.
//

import UIKit

class ProfileHeaderCell: UICollectionViewCell {
    // MARK: - Constants
    private static let avatarWidth: CGFloat = 100.0
    
    // MARK: UI components
    private lazy var avatarImageView: UIImageView = {
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
        return label
    }()
    
    private lazy var handleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followingCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    private lazy var followingTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var followingStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [followingCountLabel, followingTitleLabel])
        stack.axis = .vertical
        stack.spacing = 5.0
        stack.alignment = .center
        return stack
    }()
    
    private lazy var followerCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    private lazy var followerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
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
        label.textColor = .label
        return label
    }()
    
    private lazy var likesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
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
        stack.spacing = 12.0
        stack.alignment = .center
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var avatarShadowContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: Setup
    private func setupUI() {
        contentView.addSubview(avatarShadowContainer)
        avatarShadowContainer.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(handleLabel)
        contentView.addSubview(statsView)
        avatarImageView.layer.cornerRadius = Self.avatarWidth / 2
        
        avatarShadowContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.width.equalTo(Self.avatarWidth)
            make.centerX.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        avatarShadowContainer.layer.borderColor = UIColor.black.cgColor
        avatarShadowContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
        avatarShadowContainer.layer.shadowOpacity = 0.2
        avatarShadowContainer.layer.shadowRadius = 6
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarShadowContainer.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        handleLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(6)
            make.centerY.equalTo(nameLabel)
        }
        
        statsView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.height.equalTo(60)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    // MARK: Public Methods
    public func configure(with model: CatSimpleInfoModel) {
        nameLabel.text = model.name
        handleLabel.text = "@英短"

        // 设置头像图片
        avatarImageView.image = model.avatarImage
        avatarImageView.layer.borderColor = model.healthCondition.color.cgColor
        avatarImageView.layer.borderWidth = 5.0
        
        // 暂时使用模拟数据
        followingCountLabel.text = "42"
        followingTitleLabel.text = "关注"

        followerCountLabel.text = "128"
        followerTitleLabel.text = "粉丝"

        likesCountLabel.text = "256"
        likesTitleLabel.text = "获赞"
    }
}
