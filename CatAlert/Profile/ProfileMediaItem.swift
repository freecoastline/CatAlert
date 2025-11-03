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

// MARK: - 测试代码(之后删除)
extension ProfileMediaItem {
    static func test() {
        let testImage = UIImage(systemName: "photo")

        // 测试创建图片
        let imageItem = ProfileMediaItem.image(testImage, playCount: 10)
        print("图片类型: \(imageItem.type)")  // 应该打印: image

        // 测试创建视频
        let testURL = URL(string: "https://test.com/video.mp4")!
        let videoItem = ProfileMediaItem.video(thumbnail: testImage, videoURL: testURL, playCount: 100)
        print("视频类型: \(videoItem.type)")  // 应该打印: video
    }
}
