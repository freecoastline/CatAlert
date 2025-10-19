//
//  TaskCardView.swift
//  CatAlert
//
//  Created by ken on 2025/9/26.
//

import Foundation
import UIKit

class TaskCardView:UIView {
    private var activityId:UUID?
    var onComplete: ((UUID) -> Void)?
    private static let buttonIconSize:CGFloat = 60.0
    
    private func createButtonImage(_ sysName: String) -> UIImage {
        let configuration = UIImage.SymbolConfiguration(pointSize: Self.buttonIconSize, weight: .medium)
        guard let image =  UIImage(systemName: sysName, withConfiguration: configuration) else {
            return UIImage()
        }
        return image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(iconImageView)
        containerView.addSubview(completeButton)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.top.equalToSuperview().offset(12)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalTo(titleLabel)
        }
        
        completeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(40)
            make.centerY.equalToSuperview()
        }
    }
    
    private static let dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter
    }()
    
    func configure(with activity:ActivityRecord) {
        resetToDefaultState()
        titleLabel.text  = activity.typeString
        timeLabel.text = Self.dateFormatter.string(from: activity.scheduledTime)
        configureIcon(for: activity.type)
        applyStatusStyle(with: activity.status)
        activityId = activity.id
    }
    
    private func applyStatusStyle(with status: ActivityStatus) {
        switch status {
        case .completed:
            containerView.alpha = 0.6
            completeButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            completeButton.tintColor = .systemGreen
            completeButton.isEnabled = false
        case .expired:
            containerView.alpha = 0.4
            timeLabel.textColor = .systemRed
            completeButton.isEnabled = false
        case .pending:
            containerView.alpha = 1.0
            completeButton.isEnabled = true
        case .skipped:
            containerView.alpha = 0.5
        }
    }
    
    private func resetToDefaultState() {
        timeLabel.textColor = .secondaryLabel
        containerView.alpha = 1.0
        completeButton.isEnabled = true
        completeButton.tintColor = .systemGray
        completeButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
    }
    
    private func configureIcon(for type:CatCareType) {
        switch type {
        case .food:
            iconImageView.image = UIImage(systemName: "fork.knife")
            iconImageView.backgroundColor = .systemOrange
            iconImageView.tintColor = .white  // 添加白色前景色
        case .water:
            iconImageView.image = UIImage(systemName: "drop.fill")
            iconImageView.backgroundColor = .systemBlue
            iconImageView.tintColor = .white  // 添加白色前景色
        case .play:
            iconImageView.image = UIImage(systemName: "gamecontroller.fill")
            iconImageView.backgroundColor = .systemGreen
            iconImageView.tintColor = .white  // 添加白色前景色
        }
    }
    
    
// MARK: - UI Components
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
        view.contentMode = .center
        view.clipsToBounds = true
        view.layer.cornerRadius = 8.0
        return view
    }()
    
    private lazy var completeButton = {
        let button = UIButton(type: .custom)
        button.setImage(createButtonImage("checkmark.circle"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(tapComplete), for: .touchUpInside)
        return button
    }()
    
    @objc private func tapComplete() {
        guard let activityId, let onComplete else {
            return
        }
        completeButton.isEnabled = false
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self else { return }
            containerView.alpha = 0.6
            completeButton.setImage(createButtonImage("checkmark.circle.fill"), for: .normal)
            completeButton.tintColor = .systemGreen
        }
        onComplete(activityId)
    }
}
