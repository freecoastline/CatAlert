//
//  ProfileHeaderCell.swift
//  CatAlert
//
//  Created by ken on 2025/10/22.
//

import UIKit

class ProfileHeaderCell: UICollectionViewCell {
    // MARK: - Constants
    private static let avatarWidth:CGFloat = 100.0
    
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
    
    // MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
    // MARK: Setup
    private func setupUI() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(handleLabel)
        contentView.addSubview(statsView)
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.width.equalTo(Self.avatarWidth)
            make.centerX.equalToSuperview()
        }
        
        
    }
    
    // MARK: Public Methods
    public func configure(with model: CatModel) {
        nameLabel.text = model.name
        handleLabel.text = "@\(model.kind)"

        // 设置头像图片
        if let firstImage = model.images.first {
            avatarImageView.image = firstImage
        }

        // 暂时使用模拟数据
        followingCountLabel.text = "42"
        followingTitleLabel.text = "关注"

        followerCountLabel.text = "128"
        followerTitleLabel.text = "粉丝"

        likesCountLabel.text = "256"
        likesTitleLabel.text = "获赞"
    }
}
