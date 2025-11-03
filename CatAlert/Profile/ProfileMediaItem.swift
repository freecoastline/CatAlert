//
//  ProfileMediaItem.swift
//  CatAlert
//
//  Created by ken on 2025/11/3.
//

import UIKit

enum MediaType {
    case image
    case video
}

struct ProfileMediaItem {
    let type: MediaType
    let imageData: UIImage?
    let playCount: Int
    
    // MARK: - convenience init
    
}
