//
//  UIConstants.swift
//  CatAlert
//
//  Created by ken on 2025/12/18.
//

import Foundation

enum UIConstants {
    enum Animation {
        static let standardDuration: TimeInterval = 0.3
        static let SpringDamping: CGFloat = 0.7
        static let initialSpringVelocity: CGFloat = 0.5
    }
    
    // MARK: - ImageZoom
    enum ImageZoom {
        static let minimumScale: CGFloat = 0.5
        static let maximumScale: CGFloat = 3.0
        static let dismissThreshold: CGFloat = 0.8
    }
    
    // MARK: - CellSize
    enum CellSize {
        static let profileHeader: CGFloat = 200.0
        static let profileBio: CGFloat = 60.0
    }
}
