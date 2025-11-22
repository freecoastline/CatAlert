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
    
    
    
}
