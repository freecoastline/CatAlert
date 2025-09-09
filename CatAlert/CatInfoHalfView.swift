//
//  CatInfoHalfView.swift
//  CatAlert
//
//  Created by ken on 2025/9/9.
//

import Foundation
import UIKit

class CatInfoHalfView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
