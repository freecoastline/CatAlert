//
//  CatImageCell.swift
//  CatAlert
//
//  Created by ken on 2025/9/16.
//

import Foundation
import UIKit

class CatAlbumCell:UICollectionViewCell {
    var photo = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        contentView.addSubview(photo)
        photo.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        photo.contentMode = .scaleAspectFit
    }
    
    func updateWithImage(_ image:UIImage) {
        photo.image = image
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
