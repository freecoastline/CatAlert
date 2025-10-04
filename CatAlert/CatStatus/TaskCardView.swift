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
    
    func configure(with activity:ActivityRecord) {
        
    }
    
// MARK: UIComponnets
    private lazy var containerView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.sizeToFit()
        return label
    }()
    
    private lazy var timeLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.sizeToFit()
        return label
    }()
    
    private lazy var completeButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(tapComplete), for: .touchUpInside)
        return button
    }()
    
    @objc private func tapComplete() {
        
    }
}
