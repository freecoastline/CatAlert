//
//  ProfileViewModel.swift
//  CatAlert
//
//  Created by ken on 2025/12/23.
//

import Foundation
import Combine
import UIKit

class ProfileViewModel: ObservableObject {
    @Published var albumMediaItems: [ProfileMediaItem] = []
    @Published var favoriteMediaItems: [ProfileMediaItem] = []
    @Published var likeMediaItems: [ProfileMediaItem] = []
    
    @Published var currentTab: ProfileActionBar.Tab = .album
    
    var currentTabMediaItems: [ProfileMediaItem] {
        switch currentTab {
        case .album:
            return albumMediaItems
        case .favorite:
            return favoriteMediaItems
        case .like:
            return likeMediaItems
        }
    }
    
    func loadMockData() {
        let imageKeys = [
            "IMG_4933", "IMG_5771", "IMG_6317", "IMG_6364",
            "IMG_7585", "IMG_7595", "IMG_4933", "IMG_5771",
            "IMG_6317", "IMG_6364", "IMG_7585", "IMG_7595",
            "IMG_4933", "IMG_5771", "IMG_6317", "IMG_6364",
            "IMG_7585", "IMG_7595"
        ]

        albumMediaItems = imageKeys.enumerated().map { index, imageKey in
            if index % 2 == 0 {
                return ProfileMediaItem.image(imageKey, playCount: index * 10)
            } else {
                let videoURL = URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/360/Big_Buck_Bunny_360_10s_1MB.mp4")
                return ProfileMediaItem.video(imageKey, videoURL: videoURL, playCount: index * 10)
            }
        }

        favoriteMediaItems = Array(albumMediaItems.prefix(6))
        likeMediaItems = Array(albumMediaItems.prefix(3))
    }

    /// Add an image to the album
    func addMediaToAlbum(image: UIImage) {
        let cacheKey = UUID().uuidString
        MediaCacheManager.shared.cacheImage(image, forKey: cacheKey)
        let mediaItem = ProfileMediaItem.image(cacheKey, playCount: 0)
        albumMediaItems.insert(mediaItem, at: 0)
    }

    /// Add a video to the album
    func addMediaToAlbum(videoURL: URL, thumbnail: UIImage) {
        let cacheKey = UUID().uuidString
        MediaCacheManager.shared.cacheImage(thumbnail, forKey: cacheKey)
        let mediaItem = ProfileMediaItem.video(cacheKey, videoURL: videoURL, playCount: 0)
        albumMediaItems.insert(mediaItem, at: 0)
    }

    /// Switch to a different tab
    func switchTab(to tab: ProfileActionBar.Tab) {
        guard tab != currentTab else { return }
        currentTab = tab
    }
    
}
