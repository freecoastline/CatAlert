//
//  CatImageCell.swift
//  CatAlert
//
//  Created by ken on 2025/9/16.
//

import Foundation
import UIKit

class CatAlbumCell:UITableViewCell {
    var photo = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func updateWithImage(_ image:UIImage) {
        contentView.addSubview(photo)
        photo.image = image
        photo.contentMode = .scaleAspectFit
        photo.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
            make.size.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
