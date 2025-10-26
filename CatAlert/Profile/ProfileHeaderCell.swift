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
        stack.distribution = .fillEqually
        stack.spacing = 12.0
        stack.alignment = .center
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var avatarShadowContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground // 设置背景色以形成间隙效果
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

        // 设置容器圆角（边框会显示在这里）
        avatarShadowContainer.layer.cornerRadius = Self.avatarWidth / 2

        // 设置头像图片圆角（稍小一点以形成间隙）
        let borderWidth: CGFloat = 3.0  // 边框宽度
        let gapWidth: CGFloat = 3.0     // 边框内侧的间隙宽度
        // 注意：border 是居中绘制的，一半在内一半在外
        // 所以实际需要的内边距 = border宽度的一半 + 想要的间隙
        let imageInset: CGFloat = (borderWidth / 2) + gapWidth // 1.5 + 3 = 4.5pt
        avatarImageView.layer.cornerRadius = (Self.avatarWidth - imageInset * 2) / 2

        avatarShadowContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.width.equalTo(Self.avatarWidth)
            make.centerX.equalToSuperview()
        }

        avatarImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(imageInset)
        }

        // 阴影效果
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
            make.centerX.equalToSuperview()
            make.width.equalTo(220)
        }
    }
    
    // MARK: Public Methods
    public func configure(with model: CatSimpleInfoModel) {
        nameLabel.text = model.name
        handleLabel.text = "@英短"

        // 设置头像图片
        avatarImageView.image = model.avatarImage

        // 将边框设置在容器上，这样边框和图片之间会有间隙
        avatarShadowContainer.layer.borderColor = model.healthCondition.color.cgColor
        avatarShadowContainer.layer.borderWidth = 3.0
        
        // 暂时使用模拟数据
        followingCountLabel.text = "42"
        followingTitleLabel.text = "关注"

        followerCountLabel.text = "128"
        followerTitleLabel.text = "粉丝"

        likesCountLabel.text = "256"
        likesTitleLabel.text = "获赞"
    }
}
