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
    
    
}
