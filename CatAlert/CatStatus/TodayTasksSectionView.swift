//
//  TodayTasksSectionView.swift
//  CatAlert
//
//  Created by ken on 2025/9/30.
//

import Foundation
import UIKit

class TodayTasksSectionView:UIView {
    private lazy var titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.sizeToFit()
        return label
    }()
    
    private lazy var progressIndicator = ProgressIndicator()

}
