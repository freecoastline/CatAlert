//
//  SelectionCell.swift
//  CatAlert
//
//  Created by ken on 2025/10/12.
//

import Foundation
import UIKit

class SelectionCell:UITableViewCell {
    private lazy var iconLabel = { // 🏷️ 或 🔁
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()
    
    private lazy var titleLabel = { // "类型" 或 "频率"
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()
    
    private lazy var valueLabel = { // "喂食" 或 "每天"
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()
    
    private lazy var arrowImageView = {
        let view = UIImageView()
        view.image = .init(systemName: "greaterthan")
        return view
    }()
    
    private lazy var containerView = UIView()
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(iconLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(valueLabel)
        containerView.addSubview(arrowImageView)
        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.bottom.equalToSuperview()
        }
        
        iconLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconLabel.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { make in
            make.right.equalTo(titleLabel.snp.left).offset(-12)
            make.centerY.equalToSuperview()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
