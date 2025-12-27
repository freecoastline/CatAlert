//
//  CameraViewController.swift
//  CatAlert
//
//  Created by ken on 2025/12/27.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    // MARK: - Properties
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private let sessionManager = CameraSessionManager.shared
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        setupPreviewLayer()
        setupCloseButton()
    }
    
    private func setupPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: sessionManager.session)
        guard let previewLayer else {
            
            return
        }
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.insertSublayer(previewLayer, at: 0)
    }
   
    private func setupCloseButton() {
        
    }
    
    // MARK: - UI components
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        return button
    }
    
}
