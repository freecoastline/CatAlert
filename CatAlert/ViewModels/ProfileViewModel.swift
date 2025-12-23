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
    
}
