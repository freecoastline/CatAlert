//
//  ReminderCollectionViewCell.swift
//  CatAlert
//
//  Created by ken on 2025/12/12.
//

import Foundation
import UIKit

class ReminderCollectionViewCell: UICollectionViewCell {
    private lazy var containerView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.clipsToBounds = true
        return view
    }()
    
    private var reminder: CatReminder?
    
    var onToggle: ((String, Bool) async -> Void)?
    
    private lazy var typeIconLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private lazy var timeLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private lazy var enableSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return toggle
    }()
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        guard let reminderId = reminder?.id else {
            return
        }
        sender.isEnabled = false
        Task {
            await onToggle?(reminderId, sender.isOn)
            
            await MainActor.run {
                sender.isEnabled = true
            }
        }
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with reminder: CatReminder) {
        self.reminder = reminder
        titleLabel.text = reminder.title
        switch reminder.type {
        case .food:
            typeIconLabel.text = "🍖"
            containerView.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.1)
        case .water:
            typeIconLabel.text = "💧"
            containerView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        case .play:
            typeIconLabel.text = "🎾"
            containerView.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.1)
        }
        
        enableSwitch.isOn = reminder.isEnabled
        timeLabel.text = formatTimeAndFrequency(reminder.scheduledTime, frequency: reminder.frequency)
    }
    
    private func formatTimeAndFrequency(_ scheduledTimes: [ReminderTime], frequency: ReminderFrequency) -> String {
        let sortedTimes = scheduledTimes.sorted { t1, t2 in
            (t1.hour, t1.minute) < (t2.hour, t2.minute)
        }
        
        let timeString =  sortedTimes.map { time in
            return time.displayTime
        }
        
        let frequencyString = frequency == .daily ? "每天" : "每周"
        return frequencyString + " " + timeString.joined(separator: ",")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(typeIconLabel)
        containerView.addSubview(enableSwitch)
        
        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(80)
        }
        
        typeIconLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(typeIconLabel.snp.right).offset(12)
            make.right.equalTo(enableSwitch.snp.left).offset(-12)
            make.top.equalToSuperview().offset(20)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.right.equalTo(titleLabel)
        }
        
        enableSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
        }
    }
}
