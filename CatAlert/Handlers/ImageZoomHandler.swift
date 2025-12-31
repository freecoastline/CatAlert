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
    lazy var imageZoomBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.8)
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    lazy var imageZoomImageView: UIImageView = {
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
    
    
    // MARK: - Public Methods
    @objc private func handleSingleTap() {
        dismiss()
    }
    
    private func dismiss() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            imageZoomBackgroundView.alpha = 0
            imageZoomImageView.frame = zoomedCellFrame
        } completion: { [weak self] _ in
            guard let self else { return }
            resetImageZoomState()
        }
    }
    
    private func resetImageZoomState() {
        self.currentScale = 1.0
        self.lastScale = 1.0
        self.imageZoomImageView.image = nil
        self.imageZoomBackgroundView.isHidden = true
        self.imageZoomImageView.transform = .identity
        self.imageZoomImageView.isHidden = true
    }
    
    @objc private func handleImagePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let imageView = gesture.view else {
            return
        }
        switch gesture.state {
        case .began:
            lastScale = currentScale
        case .changed:
            currentScale = min(max(UIConstants.ImageZoom.minimumScale, gesture.scale * lastScale), UIConstants.ImageZoom.maximumScale)
            imageView.transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
        case .ended, .cancelled:
            if currentScale < UIConstants.ImageZoom.dismissThreshold {
                dismiss()
            } else if currentScale < 1.0 {
                currentScale = 1.0
                UIView.animate(withDuration: UIConstants.Animation.standardDuration, delay: 0, usingSpringWithDamping: UIConstants.Animation.springDamping, initialSpringVelocity: UIConstants.Animation.initialSpringVelocity, options: .curveEaseOut) {
                    imageView.transform = .identity
                }
            }
        default:
            break
        }
    }
    
    @objc private func handleImagePan(_ gesture: UIPanGestureRecognizer) {
        guard let imageView = gesture.view else { return }
        
        switch gesture.state {
        case .began:
            imageViewOriginalCenter = imageView.center
        case .changed:
            let transition = gesture.translation(in: view)
            let newCenter = CGPoint(x: imageViewOriginalCenter.x + transition.x, y: imageViewOriginalCenter.y + transition.y)
            imageView.center = newCenter
            
            if currentScale <= 1.0 {
                let distance:CGFloat = sqrt(pow(transition.x, 2) + pow(transition.y, 2))
                let maxDistance: CGFloat = 200.0
                imageZoomBackgroundView.alpha = max(0.3, 1.0 - (distance / maxDistance) * 0.7)
                
                let scale = max(0.7, 1.0 - (distance / maxDistance) * 0.3)
                imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        case .ended, .cancelled:
            let transition = gesture.translation(in: view)
            let distance:CGFloat = sqrt(pow(transition.x, 2) + pow(transition.y, 2))
            
            if currentScale <= 1.0 {
                if distance > 150 {
                    dismiss()
                } else {
                    UIView.animate(withDuration: UIConstants.Animation.standardDuration, delay: 0, usingSpringWithDamping: UIConstants.Animation.springDamping, initialSpringVelocity: UIConstants.Animation.initialSpringVelocity, options: .curveEaseOut) {
                        [weak self] in
                        guard let self else { return }
                        imageView.center = imageViewOriginalCenter
                        imageView.transform = .identity
                        imageZoomBackgroundView.alpha = 1.0
                    }
                }
            } else {
                UIView.animate(withDuration: UIConstants.Animation.standardDuration, delay: 0, usingSpringWithDamping: UIConstants.Animation.springDamping, initialSpringVelocity: UIConstants.Animation.initialSpringVelocity, options: .curveEaseOut) {
                    [weak self] in
                    guard let self else { return }
                    imageView.center = imageViewOriginalCenter
                }
            }
        default:
            break
        }
    }
    
    @objc private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        guard let imageView = gesture.view else { return }
        let newScale = currentScale > 1.0 ? 1.0 : 2.0
        currentScale = newScale
        UIView.animate(withDuration: UIConstants.Animation.standardDuration, delay: 0, usingSpringWithDamping: UIConstants.Animation.springDamping, initialSpringVelocity: UIConstants.Animation.initialSpringVelocity, options: .curveEaseOut) {
            imageView.transform = CGAffineTransform(scaleX: newScale, y: newScale)
        }
    }
    
}

extension ImageZoomHandler: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

