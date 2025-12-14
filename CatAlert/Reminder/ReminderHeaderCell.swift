//
//  ReminderHeaderCell.swift
//  CatAlert
//
//  Created by ken on 2025/12/13.
//

import Foundation
import UIKit

class ReminderHeaderCell: UICollectionViewCell {
    // MARK: - Properties
    static let reuseIdentifier = "ReminderHeaderCell"
    
    
    // MARK: - UI Components
    private lazy var iconLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
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
        contentView.addSubview(iconLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        iconLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.height.width.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconLabel.snp.trailing).offset(8)
            make.centerY.equalTo(iconLabel)
        }
        
        countLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.centerY.equalTo(titleLabel)
        }
    }
    
    func configure(with model: ReminderSectionHeaderModel) {
        switch model.type {
        case .food:
            iconLabel.text = "🍖"
            titleLabel.text = "喂食"
        case .water:
            iconLabel.text = "💧"
            titleLabel.text = "喂水"
        case .play:
            iconLabel.text = "🎾"
            titleLabel.text = "玩耍"
        }

        countLabel.text = "\(model.count) 个提醒"
    }
}
