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
    let breedView = CatInfoMiddleView()
    let genderView = CatInfoMiddleView()
    
    func updateWithModel(_ model: CatModel) {
        currentModel = model
        desc.text = model.description
        breedView.updateWithModel(model)
        genderView.updateWithModel(model)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    lazy var desc = {
        let descLabel = UILabel()
        descLabel.numberOfLines = 0
        descLabel.sizeToFit()
        descLabel.textColor = .gray
        return descLabel
    }()
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    func setupUI() {
        breedView.type = .Kind
        genderView.type = .Gender
        addSubview(breedView)
        addSubview(genderView)
        addSubview(desc)
        breedView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview()
        }
        genderView.snp.makeConstraints { make in
            make.centerY.equalTo(breedView)
            make.leading.equalTo(breedView.snp.trailing).offset(100)
        }
        desc.snp.makeConstraints { make in
            make.top.equalTo(breedView.snp.bottom).offset(50)
        }
        
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
