//
//  TextFieldcell.swift
//  CatAlert
//
//  Created by ken on 2025/10/11.
//

import UIKit

class TextFieldCell:UITableViewCell {
    private lazy var iconLabel = {
        let label = UILabel()
        label.text = "📝"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var textField = {
        let field = UITextField()
        field.placeholder = "[请输入提醒标题______________]"
        field.font = .systemFont(ofSize: 16)
        return field
    }()
    
    private lazy var containerView = {
        let container = UIView()
        return container
    }()
    
    var onTextChanged:((String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(iconLabel)
        containerView.addSubview(textField)
        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.bottom.equalToSuperview()
        }
        
        iconLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.left.equalTo(iconLabel.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
