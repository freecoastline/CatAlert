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
    let thumbnail: UIImage?
    let videoURL: URL?
    let playCount: Int
    
    // MARK: - convenience init
    static func image(_ imageData: UIImage?, playCount: Int) -> ProfileMediaItem {
        ProfileMediaItem(type: .image, imageData: imageData, thumbnail: imageData, videoURL: nil, playCount: 0)
    }
    
    static func video(thumbnail: UIImage?, videoURL: URL?, playCount:Int) -> ProfileMediaItem {
        ProfileMediaItem(type: .video, imageData: nil, thumbnail: thumbnail, videoURL: videoURL, playCount: 0)
    }
}

