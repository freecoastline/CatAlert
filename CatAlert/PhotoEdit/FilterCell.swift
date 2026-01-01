//
//  FilterCell.swift
//  CatAlert
//
//  Created by ken on 2026/1/1.
//

import Foundation
import UIKit

class FilterCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "FilterCell"
    
    // MARK: - UI Components
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
        }
    }
    
}
