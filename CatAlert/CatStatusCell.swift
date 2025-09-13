//
//  CatStatusCell.swift
//  CatAlert
//
//  Created by wuyawei.ken on 2025/9/12.
//

import Foundation
import UIKit

class CatStatusCell:UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
