//
//  CatInfoHalfView.swift
//  CatAlert
//
//  Created by ken on 2025/9/9.
//

import Foundation
import UIKit

class CatInfoHalfView: UIView {
    lazy var catStatusViewModel = CatViewModel()
    lazy var nameLabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .purple
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        nameLabel.text = catStatusViewModel.name()
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(30)
        }
        let segmentTableVC = CatInfoSegmentTableController()
        addSubview(segmentTableVC.view)
        segmentTableVC.view.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.height.equalTo(500)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
        }
        backgroundColor = .white
        layer.cornerRadius = 15
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
