//
//  PhotoFilter.swift
//  CatAlert
//
//  Created by ken on 2026/1/1.
//

import Foundation

enum PhotoFilter: String, CaseIterable {
    case original = "Original"
    case vivid = "Vivid"
    case noir = "Noir"
    case chrome = "Chrome"
    case fade = "Fade"
    case mono = "Mono"

    var filterName: String {
        return self.rawValue
    }

    var ciFilterName: String? {
        switch self {
        case .original:
            return nil  // No filter applied
        case .vivid:
            return "CIColorControls"  // Increase saturation
        case .noir:
            return "CIPhotoEffectNoir"
        case .chrome:
            return "CIPhotoEffectChrome"
        case .fade:
            return "CIPhotoEffectFade"
        case .mono:
            return "CIPhotoEffectMono"
        }
    }
}
