//
//  CatInfoCell.swift
//  CatAlert
//
//  Created by wuyawei.ken on 2025/9/12.
//

import Foundation
import UIKit

class CatInfoCell: UITableViewCell {
    var currentModel: CatModel?
    
    func updateWithModel(_ model: CatModel) {
        currentModel = model
        desc.text = model.description
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    lazy var desc = {
        let descLabel = UILabel()
        descLabel.numberOfLines = 0
        descLabel.sizeToFit()
        return descLabel
    }()
    
    func setupUI() {
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
