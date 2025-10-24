//
//  ProfileBioCell.swift
//  CatAlert
//
//  Created by ken on 2025/10/24.
//

import UIKit

class ProfileBioCell: UICollectionViewCell {
    // MARK: - UI component
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        contentView.addSubview(bioLabel)
        bioLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview().inset(5)
        }
    }
    
    // MARK: - Configure
    public func configure(with model: CatSimpleInfoModel) {
        bioLabel.text = "年龄：\(model.age)  健康状态： \(model.healthCondition.displayText)"
    }
}

