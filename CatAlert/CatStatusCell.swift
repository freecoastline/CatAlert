//
//  CatStatusCell.swift
//  CatAlert
//
//  Created by wuyawei.ken on 2025/9/12.
//

import Foundation
import UIKit

class CatStatusCell:UITableViewCell {
    let checkListButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(checkListButton)
        checkListButton.setTitle("Daily Care", for: .normal)
        checkListButton.layer.cornerRadius = 15
        checkListButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        checkListButton.contentHorizontalAlignment = .left
        checkListButton.backgroundColor = .purple
        checkListButton.addTarget(self, action: #selector(touchDown), for: .touchDown)
        checkListButton.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        checkListButton.addTarget(self, action: #selector(touchUpOutside), for: .touchUpOutside)
    }
    
    
    @objc
    func touchDown() {
        checkListButton.backgroundColor = .clear
    }
    
    
    @objc
    func touchUpInside() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self else {
                return
            }
            checkListButton.backgroundColor = .purple
        }
        
    }
    
    @objc
    func touchUpOutside() {
        checkListButton.backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
