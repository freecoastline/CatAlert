//
//  ImageZoomHandler.swift
//  CatAlert
//
//  Created by ken on 2025/12/23.
//

import Foundation
import UIKit
class ImageZoomHandler: NSObject {
    // MARK: - Properties
    private var lastScale: CGFloat = 1.0
    private var currentScale: CGFloat = 1.0
    private var imageViewOriginalCenter: CGPoint = .zero
    
    private var zoomedCellFrame: CGRect = .zero
    
    // MARK: - UI Components
    lazy var imageZoomedBackGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.8)
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    lazy var imageZoomImageView: UIView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
}
