//
//  CatInfoCollectionCell.swift
//  CatAlert
//
//  Created by ken on 2025/12/7.
//

import Foundation
import UIKit

class CatInfoCollectionCell: UICollectionViewCell {
    // MARK: - Static
    static let reuseIdentifier = "CatInfoCollectionCell"
    
    // MARK: - Property
    private lazy var headerView = CatInfoHeaderView(frame: .zero)
    
    weak var delegate: CatInfoHeaderViewDelegate?
    
    private var catInfo: CatSimpleInfoModel?
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        contentView.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - Configure
    func configure(with info: CatSimpleInfoModel) {
        catInfo = info
        headerView.update(with: info)
        headerView.delegate = delegate
    }
}
