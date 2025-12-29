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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sessionManager.stopSession()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        setupPreviewLayer()
        Task {
            await setupCameraSession()
        }
        setupCloseButton()
    }
    
    private func setupCameraSession() async {
        let granted = await sessionManager.requestCameraPermission()
        guard granted else {
            await MainActor.run {
                AlertManager.shared.showAlert("Camera permission denied", on: self)
            }
            return
        }
        do {
            try await sessionManager.setupCamera()
            sessionManager.startSession()
        } catch {
            await MainActor.run {
                AlertManager.shared.showAlert("Failed to setup camera: \(error.localizedDescription)", on: self)
            }
        }
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
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }
        
    }
    
    // MARK: - UI components
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Action
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}
