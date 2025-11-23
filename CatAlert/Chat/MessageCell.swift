//
//  MessageCell.swift
//  CatAlert
//
//  Created by ken on 2025/11/22.
//

import Foundation
import UIKit
 
class MessageCell: UITableViewCell {
    // MARK: - UI Component
    private let bubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Setup
    private func setupUI() {
        contentView.backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(with message: ChatMessage) {
        messageLabel.text = message.content
        if message.role == .user {
            bubbleView.backgroundColor = .systemBlue
            messageLabel.textColor = .white
            
            bubbleView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(8)
                make.bottom.equalToSuperview().offset(-8)
                make.trailing.equalToSuperview().offset(-16)
                make.leading.greaterThanOrEqualToSuperview().offset(80)
            }
        } else if message.role == .assistant {
            bubbleView.backgroundColor = .systemGray
            messageLabel.textColor = .label
            bubbleView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(8)
                make.bottom.equalToSuperview().offset(-8)
                make.leading.equalToSuperview().offset(16)
                make.trailing.lessThanOrEqualToSuperview().offset(-80)
            }
        }
    }
    
}
