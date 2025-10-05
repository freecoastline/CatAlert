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
    
    private var dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter
    }()
    
    func configure(with activity:ActivityRecord) {
        titleLabel.text  = activity.typeString
        timeLabel.text = dateFormatter.string(from: activity.scheduledTime)

        
    }
    
    private func configureIcon(for type:CatCareType) {
        iconImageView.clipsToBounds = true
        iconImageView.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(40)
            make.centerY.equalToSuperview()
        }
        switch type {
        case .food:
            iconImageView.image = UIImage(systemName: "fork.knife")
            iconImageView.backgroundColor = .systemOrange
        case .water:
            iconImageView.image = UIImage(systemName: "drop.fill")
            iconImageView.backgroundColor = .systemBlue
        case .play:
            iconImageView.image = UIImage(systemName: "gamecontroller.fill")
            iconImageView.backgroundColor = .systemGreen
        }
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
    
    private lazy var iconImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var completeButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(tapComplete), for: .touchUpInside)
        return button
    }()
    
    @objc private func tapComplete() {
        
    }
}
