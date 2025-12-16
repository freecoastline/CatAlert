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
    
    struct PerformanceMetrics {
        
    }
    
    // MARK: - imageCache
    private let imageCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private lazy var cacheDirectory: URL = {
        let paths = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        let url = paths[0].appending(path: "MediaCache", directoryHint: .isDirectory)
        try? fileManager.createDirectory(at: url, withIntermediateDirectories: true)
        return url
    }()
    
    // MARK: - Performance Metrics
    //private(set) var performance = PerformanceMetrics()
    
    // MARK: - Init
    private init() {
        configureCache()
    }
    
    // MARK: - Configure
    private func configureCache() {
        imageCache.countLimit = 100
        imageCache.totalCostLimit = 50 * 1024 * 1024 //50 MB
    }
    
}
