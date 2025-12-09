//
//  CatInfoHeaderView.swift
//  CatAlert
//
//  Created by ken on 2025/9/28.
//

import Foundation
import UIKit

protocol CatInfoHeaderViewDelegate: AnyObject {
    func didTapAvatar()
}

class CatInfoHeaderView: UIView {
    var delegate:CatInfoHeaderViewDelegate?
    private static let avatarSize:CGFloat = 56  // 增大头像
    private static let animationDuration: TimeInterval = 0.1
    private static let scaleDown: CGFloat = 0.95
    private static let indicatorSize: CGFloat = 10.0  // 减小指示点
    private static let badgeHeight: CGFloat = 32.0  // 略微减小徽章高度
    private static let badgePadding: CGFloat = 10.0
    private static let onlineIndicatorSize: CGFloat = 14.0  // 在线状态指示器
    
    // ✨ 头像容器（用于添加边框和阴影）
    private lazy var avatarContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = Self.avatarSize / 2

        // 添加边框
        container.layer.borderWidth = 3
        container.layer.borderColor = UIColor.white.cgColor

        // 添加阴影
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.15
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowRadius = 6

        return container
    }()

    private lazy var avatarImageView = {
        let avatar = UIImageView()
        avatar.contentMode = .scaleAspectFill
        avatar.layer.cornerRadius = (Self.avatarSize - 6) / 2  // 减去边框宽度
        avatar.layer.masksToBounds = true
        avatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAvatar)))
        avatar.isUserInteractionEnabled = true
        return avatar
    }()

    // ✨ 在线状态指示器
    private lazy var onlineIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = Self.onlineIndicatorSize / 2
        view.layer.borderWidth = 2.5
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    @objc private func didTapAvatar() {
        // ✨ 优化动画：同时缩放容器
        UIView.animate(withDuration: Self.animationDuration, animations: {
            self.avatarContainerView.transform = CGAffineTransform(scaleX: Self.scaleDown, y: Self.scaleDown)
        }) { _ in
            UIView.animate(
                withDuration: Self.animationDuration,
                delay: 0,
                usingSpringWithDamping: 0.6,  // 添加弹簧效果
                initialSpringVelocity: 0.5,
                options: .curveEaseOut
            ) {
                self.avatarContainerView.transform = .identity
            }
        }

        // 触觉反馈
        let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
        impactGenerator.impactOccurred()

        delegate?.didTapAvatar()
    }
    
    // ✨ 名字和年龄的容器（垂直布局）
    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 2
        return stack
    }()

    private lazy var nameLabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 18, weight: .bold)  // 增大加粗
        return label
    }()

    private lazy var ageLabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 13, weight: .regular)  // 缩小作为副标题
        return label
    }()
    
    private lazy var healthIndicatorDot = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = Self.indicatorSize / 2

        // ✨ 添加脉动动画
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1.5
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 1.2
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .infinity
        view.layer.add(pulseAnimation, forKey: "pulse")

        return view
    }()
    
    private lazy var stackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12.0
        return stack
    }()
    
    func update(with model: CatSimpleInfoModel) {
        nameLabel.text = model.name
        ageLabel.text = String(format: "🎂 %.1f岁", model.age)  // 添加表情图标
        avatarImageView.image = model.avatarImage
        healthIndicatorDot.backgroundColor = model.healthCondition.color
        healthStatusLabel.text = model.healthCondition.displayText  // 简化文本
    }
    
    private lazy var healthStatusBadge = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 16.0

        // ✨ 优化阴影
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.08
        container.layer.shadowOffset = CGSize(width: 0, height: 1)
        container.layer.shadowRadius = 4

        // ✨ 添加内部 StackView 更好地布局
        let contentStack = UIStackView()
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.spacing = 6

        contentStack.addArrangedSubview(self.healthIndicatorDot)
        contentStack.addArrangedSubview(self.healthStatusLabel)

        container.addSubview(contentStack)

        contentStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Self.badgePadding)
            make.centerY.equalToSuperview()
        }

        self.healthIndicatorDot.snp.makeConstraints { make in
            make.width.height.equalTo(Self.indicatorSize)
        }

        return container
    }()
    
    private lazy var healthStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)  // 缩小字号
        label.textColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        // ✨ 设置背景
        backgroundColor = .white
        layer.cornerRadius = 13
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 6

        // 添加头像容器和头像
        addSubview(avatarContainerView)
        avatarContainerView.addSubview(avatarImageView)

        // 设置信息堆栈
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(ageLabel)

        // 主堆栈布局
        addSubview(stackView)
        stackView.addArrangedSubview(avatarContainerView)
        stackView.addArrangedSubview(infoStackView)

        addSubview(onlineIndicator)
        
        // 添加弹性空间
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stackView.addArrangedSubview(spacer)
        stackView.addArrangedSubview(healthStatusBadge)
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }

        avatarContainerView.snp.makeConstraints { make in
            make.width.height.equalTo(Self.avatarSize)
        }

        avatarImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(Self.avatarSize - 6)  // 减去边框
        }

        onlineIndicator.snp.makeConstraints { make in
            make.right.bottom.equalTo(avatarContainerView).offset(-2)
            make.width.height.equalTo(Self.onlineIndicatorSize)
        }

        healthStatusBadge.snp.makeConstraints { make in
            make.height.equalTo(Self.badgeHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
