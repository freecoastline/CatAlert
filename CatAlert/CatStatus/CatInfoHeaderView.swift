//
//  CatInfoHeaderView.swift
//  CatAlert
//
//  Created by ken on 2025/9/28.
//

import Foundation
import UIKit

class CatInfoHeaderView: UIView {
    private lazy var avatarImageView = {
        let avatar = UIImageView()
        avatar.contentMode = .scaleAspectFit
        return avatar
    }()
    
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
    
    private lazy var healthConditionTitle = {
        let label = UILabel()
        label.textColor = .systemPink
        label.text = "健康状态："
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()
    
    private lazy var healthyConditionView = {
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
        ageLabel.text = String(format: "%.1f", model.age)
        avatarImageView.image = model.avatarImage
        healthyConditionView.backgroundColor = model.healthCondition.color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.addArrangedSubview(avatarImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(ageLabel)
        stackView.addArrangedSubview(healthConditionTitle)
        stackView.addArrangedSubview(healthyConditionView)
        stackView.distribution = .equalSpacing
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(50)
        }
        
        healthyConditionView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(100)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
