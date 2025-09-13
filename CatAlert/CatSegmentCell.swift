//
//  CatSegmentCell.swift
//  CatAlert
//
//  Created by wuyawei.ken on 2025/9/12.
//

import Foundation
import UIKit

class CatSegmentCell:UITableViewCell {
    public var segmentControl = {
        let segmentCtr = UISegmentedControl(items: ["Profile", "Status"])
        segmentCtr.selectedSegmentIndex = 0
        return segmentCtr
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(segmentControl)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
