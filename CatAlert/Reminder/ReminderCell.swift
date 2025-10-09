//
//  ReminderCell.swift
//  CatAlert
//
//  Created by ken on 2025/10/8.
//

import Foundation
import UIKit

class ReminderCell:UITableViewCell {
    private let containerView = {
        let view = UIView()
        return view
    }()
    
    private let typeIconLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let timeLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let enableSwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with reminder: CatReminder) {
        
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(typeIconLabel)
        containerView.addSubview(enableSwitch)
        
        containerView.snp.makeConstraints { make in
            
        }
    }
    
    
    
}
 
