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
        var cacheHits: Int = 0
        var cacheMisses: Int = 0
        var totalLoadTime: TimeInterval = 0
        var loadCount: Int = 0
        
        var cacheHitRate: Double {
            let total = cacheHits + cacheMisses
            return total > 0 ? Double(total) / Double(loadCount) : 0
        }
        
        var averageLoadTime: TimeInterval {
            return loadCount > 0 ? totalLoadTime / Double(loadCount) : 0
        }
        
        mutating func reset() {
            cacheHits = 0
            cacheMisses = 0
            totalLoadTime = 0
            loadCount = 0
        }
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
    private(set) var metrics = PerformanceMetrics()
    
    // MARK: - Init
    private init() {
        configureCache()
    }
    
    // MARK: - Configure
    private func configureCache() {
        imageCache.countLimit = 100
        imageCache.totalCostLimit = 50 * 1024 * 1024 //50 MB
    }
    
    // MARK: - Public Methods
    func cacheImage(_ image: UIImage, forKey key: String) {
        imageCache.setObject(image, forKey: key as NSString)
        Task.detached(priority: .background) { [weak self] in
            guard let self else { return }
            let data = image.jpegData(compressionQuality: 0.8)
            let fileURL = cacheDirectory.appendingPathComponent(key)
            try? data?.write(to: fileURL)
        }
    }
    
    func getImage(forKey key: String) -> UIImage? {
        let startTime = CFAbsoluteTimeGetCurrent()
        if let image = imageCache.object(forKey: key as NSString) {
            let loadTime = CFAbsoluteTimeGetCurrent() - startTime
            metrics.cacheHits += 1
            metrics.totalLoadTime += loadTime
            metrics.loadCount += 1
            print("📊 [CACHE HIT - Memory] \(String(format: "%.2f", loadTime * 1000))ms")
            return image
        }
        
        let fileURL = cacheDirectory.appendingPathComponent(key)
        if let data = try? Data(contentsOf: fileURL),
           let image = UIImage(data: data) {
            imageCache.setObject(image, forKey: key as NSString)
            let loadTime = CFAbsoluteTimeGetCurrent() - startTime
            metrics.cacheHits += 1
            metrics.totalLoadTime += loadTime
            metrics.loadCount += 1
            print("📊 [CACHE HIT - Disk] \(String(format: "%.2f", loadTime * 1000))ms")
            return image
        }
        
        // Cache miss
            let loadTime = CFAbsoluteTimeGetCurrent() - startTime
            metrics.cacheMisses += 1
            metrics.totalLoadTime += loadTime
            metrics.loadCount += 1
            print("📊 [CACHE MISS] \(String(format: "%.2f", loadTime * 1000))ms")
            return nil
    }
}
