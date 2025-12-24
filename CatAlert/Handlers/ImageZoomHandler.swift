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
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        // Pinch gesture for zooming
        let pinGesture = UIPinchGestureRecognizer(target: self, action: #selector(handleImagePinch(_:)))
        imageView.addGestureRecognizer(pinGesture)
        pinGesture.delegate = self

        // Pan gesture for dragging
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleImagePan(_:)))
        imageView.addGestureRecognizer(panGesture)
        panGesture.delegate = self

        // Double-tap gesture for zoom toggle
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doubleTapGesture)
        doubleTapGesture.delegate = self

        // Single-tap gesture for dismiss
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        imageView.addGestureRecognizer(singleTapGesture)
        singleTapGesture.delegate = self
        return imageView
    }()
    
    
    
}
