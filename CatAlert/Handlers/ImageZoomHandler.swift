//
//  ImageZoomHandler.swift
//  CatAlert
//
//  Created by ken on 2025/12/23.
//

import Foundation
class ImageZoomHandler: NSObject {
    // MARK: - Properties
    private var lastScale: CGFloat = 1.0
    private var currentScale: CGFloat = 1.0
    private var imageViewOriginalCenter: CGPoint = .zero
    
    private var zoomedCellFrame: CGRect = .zero
}
