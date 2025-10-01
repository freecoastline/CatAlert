//
//  CatInfoHeaderView.swift
//  CatAlert
//
//  Created by ken on 2025/9/28.
//

import Foundation
import UIKit

protocol CatInfoHeaderViewDelegate {
    func didTapAvatar()
}

class CatInfoHeaderView: UIView {
    var delegate:CatInfoHeaderViewDelegate?
    private static let avatarSize:CGFloat = 50
    private static let animationDuration: TimeInterval = 0.1  // ✅ 动画时长固定
    private static let scaleDown: CGFloat = 0.95     // ✅ 缩放比例固定
    private static let indicatorSize: CGFloat = 20.0
    private static let badgeHeight: CGFloat = 36.0
    private static let badgePadding: CGFloat = 12.0
    
    private lazy var avatarImageView = {
        let avatar = UIImageView()
        avatar.contentMode = .scaleAspectFill
        avatar.layer.cornerRadius = Self.avatarSize / 2
        avatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAvatar)))
        return avatar
    }()
    
    @objc private func didTapAvatar() {
        UIView.animate(withDuration: Self.animationDuration, animations: {
            self.avatarImageView.transform = CGAffineTransform(scaleX: Self.scaleDown, y: Self.scaleDown)
        }) { _ in
            UIView.animate(withDuration: Self.animationDuration) {
                self.avatarImageView.transform = .identity
            }
        }
        let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
        impactGenerator.impactOccurred()
        delegate?.didTapAvatar()
    }
    
    private lazy var ageLabel = {
        let label = UILabel()
        label.textColor = .systemPink
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()
    
    private lazy var nameLabel = {
        let label = UILabel()
        label.textColor = .systemPink
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()
    
    private lazy var healthIndicatorDot = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var stackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        return stack
    }()
    
    func update(with model: CatSimpleInfoModel) {
        nameLabel.text = model.name
        ageLabel.text = String(format: "%.1f岁", model.age)
        avatarImageView.image = model.avatarImage
        healthIndicatorDot.backgroundColor = model.healthCondition.color
        healthStatusLabel.text = "健康状况：\(model.healthCondition.displayText)"
    }
    
    private lazy var healthStatusBadge = {
        let container = UIView()
        container.layer.cornerRadius = 15.0
        container.backgroundColor = .gray
        container.addSubview(self.healthStatusLabel)
        container.addSubview(self.healthIndicatorDot)
        self.healthStatusLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Self.badgePadding)
            make.centerY.equalToSuperview()
        }
        self.healthIndicatorDot.snp.makeConstraints { make in
            make.left.equalTo(self.healthStatusLabel.snp.right).offset(10)
            make.width.height.equalTo(CatInfoHeaderView.indicatorSize)
            make.right.equalToSuperview().offset(-Self.badgePadding)
            make.centerY.equalToSuperview()
        }
        self.healthIndicatorDot.layer.cornerRadius = CatInfoHeaderView.indicatorSize / 2
        return container
    }()
    
    private lazy var healthStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemPink
        label.backgroundColor = .yellow
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.addArrangedSubview(avatarImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(ageLabel)
        let spacer = UIView()
        stackView.addArrangedSubview(spacer)
        stackView.addArrangedSubview(healthStatusBadge)
        stackView.spacing = 8.0
        stackView.alignment = .center
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
        }
        healthStatusBadge.snp.makeConstraints { make in
            make.height.equalTo(Self.badgeHeight)
        }
        avatarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(Self.avatarSize)
        }
        avatarImageView.layer.masksToBounds = true
        avatarImageView.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
