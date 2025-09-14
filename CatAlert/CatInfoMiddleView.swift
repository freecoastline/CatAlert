//
//  CatInfoMidlleView.swift
//  CatAlert
//
//  Created by wuyawei.ken on 2025/9/14.
//

import Foundation
import UIKit

class CatInfoMiddleView:UIView {
    enum InfoType {
        case Kind
        case Gender
    }
    
    let type:InfoType = .Kind
    
    lazy var iconImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.sizeToFit()
        return label
    }()
    
    lazy var contentLabel = {
        let content = UILabel()
        content.font = .systemFont(ofSize: 12)
        return content
    }()
    
    func updateWithModel(_ model:CatModel) {
        if type == .Kind {
            titleLabel.text = model.bornWay
            iconImageView.image = .init(systemName: "pawprint.circle.fill")
            contentLabel.text = model.kind
        } else if type == .Gender {
            titleLabel.text = "Gender"
            iconImageView.image = .init(systemName: "figure.wave")
            contentLabel.text = model.gender
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        addSubview(titleLabel)
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview()
            make.height.width.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    
}
