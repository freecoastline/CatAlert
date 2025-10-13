//
//  TimeCell.swift
//  CatAlert
//
//  Created by ken on 2025/10/13.
//

import UIKit

class TimeCell: UITableViewCell {
    private lazy var iconLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()
    
    private lazy var indexLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()
    
    
    private lazy var timeLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private lazy var arrowImageView = {
        let view = UIImageView()
        view.image = .init(systemName: "chevron.right")
        return view
    }()
    
    private lazy var containerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(icon: String, indexString: String, timeString: String) {
        iconLabel.text = icon
        indexLabel.text = indexString
        timeLabel.text = timeString
    }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(iconLabel)
        containerView.addSubview(indexLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(arrowImageView)
        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.bottom.equalToSuperview()
        }
        
        iconLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(24)
        }
        
        indexLabel.snp.makeConstraints { make in
            make.left.equalTo(iconLabel.snp.right).offset(12)
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.right.equalTo(arrowImageView.snp.left).offset(-12)
            make.centerY.equalToSuperview()
        }
    }
}
