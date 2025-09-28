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
        avatar.image = .init(systemName: "pawprint.circle")
        return avatar
    }()
    
    private lazy var ageLabel = {
        let label = UILabel()
        label.textColor = .systemPink
        label.font = .systemFont(ofSize: 14)
        label.text = "4.5"
        label.sizeToFit()
        return label
    }()
    
    private lazy var nameLabel = {
        let label = UILabel()
        label.textColor = .systemPink
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        label.text = "胡胡"
        return label
    }()
    
    private lazy var healthConditionTitle = {
        let label = UILabel()
        label.textColor = .systemPink
        label.font = .systemFont(ofSize: 14)
        label.text = "健康状态："
        label.sizeToFit()
        return label
    }()
    
    private lazy var healthyConditionLabel = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.addArrangedSubview(avatarImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(ageLabel)
        stackView.addArrangedSubview(healthConditionTitle)
        stackView.addArrangedSubview(healthyConditionLabel)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(50)
        }
        
        healthyConditionLabel.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(100)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
