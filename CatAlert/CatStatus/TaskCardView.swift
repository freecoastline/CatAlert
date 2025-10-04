//
//  TaskCardView.swift
//  CatAlert
//
//  Created by ken on 2025/9/26.
//

import Foundation
import UIKit
import Combine

class TaskCardView:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(with activity:ActivityRecord) {
        
    }
    
// MARK: UIComponnets
    private lazy var containerView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        return view
    }()
}
