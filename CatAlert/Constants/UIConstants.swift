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
        static let springDamping: CGFloat = 0.7
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
        static let profileHeaderHeight: CGFloat = 200.0
        static let profileBioHeight: CGFloat = 60.0
        static let actionBarHeight: CGFloat = 44
    }
    
    // MARK: - MediaItemSize
    enum MediaItemParameter {
        static let spacingBetweenItem: CGFloat = 2.0
        static let totalItemInOneRow: CGFloat = 3.0
        static let widthToHeightRatio: CGFloat = 1.3
    }

    // MARK: - VideoCell
    enum VideoCell {
        static let playCountFontSize: CGFloat = 13
        static let playIconSize: CGFloat = 12
        static let playIconInset: CGFloat = 8
        static let iconLabelSpacing: CGFloat = 6
        static let thousandThreshold = 1_000
        static let tenThousandThreshold = 10_000
        static let millionThreshold = 1_000_000
    }
    
    enum ReminderForm {
        // Sections
        enum Section: Int {
            case basic = 0
            case times = 1
        }

        // Basic Section Rows
        enum BasicRow: Int {
            case title = 0
            case type = 1
            case frequency = 2
        }

        static let basicSectionRowCount = 3
    }
    
    enum Camera {
        // Capture Button
        static let captureButtonSize: CGFloat = 70
        static let captureButtonCornerRadius: CGFloat = 35  // Half of size for circle
        static let captureButtonBorderWidth: CGFloat = 5
        static let captureButtonBorderAlpha: CGFloat = 0.5

        // Shadow
        static let shadowOpacity: Float = 0.3
        static let shadowRadius: CGFloat = 4
        static let shadowOffset = CGSize(width: 0, height: 2)

        // Layout
        static let captureButtonBottomOffset: CGFloat = -30
        static let closeButtonSize: CGFloat = 40
        static let closeButtonTopOffset: CGFloat = 16
        static let closeButtonLeadingOffset: CGFloat = 16
    }
}


