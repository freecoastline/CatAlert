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
    let imageKey: String?
    let thumbnail: UIImage?
    let videoURL: URL?
    let playCount: Int
    
    // MARK: - convenience init
    static func image(_ imageKey: String?, playCount: Int) -> ProfileMediaItem {
        ProfileMediaItem(type: .image, imageData: nil, imageKey: imageKey, thumbnail: nil, videoURL: nil, playCount: playCount)
    }
    
    static func video(_ imageKey: String?, videoURL: URL?, playCount:Int) -> ProfileMediaItem {
        ProfileMediaItem(type: .video, imageData: nil, imageKey: imageKey, thumbnail: nil, videoURL: videoURL, playCount: playCount)
    }
}

