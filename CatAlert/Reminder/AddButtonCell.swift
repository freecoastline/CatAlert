//
//  AddButtonCell.swift
//  CatAlert
//
//  Created by ken on 2025/10/13.
//

import UIKit

class AddButtonCell: UITableViewCell {
    var onTapAdd: (() -> Void)?
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.setTitle("➕ 添加提醒时间", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    @objc private func addButtonTapped() {
         onTapAdd?()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
