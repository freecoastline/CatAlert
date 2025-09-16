//
//  CatImageCell.swift
//  CatAlert
//
//  Created by ken on 2025/9/16.
//

import Foundation
import UIKit

class CatAlbumCell:UITableViewCell {
    var catImage:UIImage?
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
