//
//  MediaCacheManager.swift
//  CatAlert
//
//  Created by ken on 2025/12/15.
//

import Foundation
import UIKit

class MediaCacheManager {
    // MARK: - Property
    static let shared = MediaCacheManager()
    private init() {}
    
    // MARK: - imageCache
    private let imageCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    
}
