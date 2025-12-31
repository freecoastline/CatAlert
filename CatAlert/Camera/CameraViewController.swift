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
    
    // MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .black
        setupPreviewLayer()
        Task {
            await setupCameraSession()
        }
        setupCloseButton()
        setupCaptureButton()
    }
    
    private func setupCaptureButton() {
        view.addSubview(captureButton)
        captureButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(UIConstants.Camera.captureButtonBottomOffset)
            make.height.width.equalTo(UIConstants.Camera.captureButtonSize)
        }
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
    
    private lazy var captureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = UIConstants.Camera.captureButtonCornerRadius
        button.layer.borderColor = UIColor.white.withAlphaComponent(UIConstants.Camera.captureButtonBorderAlpha).cgColor
        button.layer.borderWidth = UIConstants.Camera.captureButtonBorderWidth
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = UIConstants.Camera.shadowOffset
        button.layer.shadowOpacity = UIConstants.Camera.shadowOpacity
        button.layer.shadowRadius = UIConstants.Camera.shadowRadius
        button.addTarget(self, action: #selector(captureButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Action
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func captureButtonTapped() {
        animateCaptureButton()
    }
    
    // MARK: - Helper Method
    private func animateCaptureButton() {
        UIView.animate(withDuration: 0.1) { [weak self] in
            guard let self else { return }
            captureButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) { [weak self] in
                guard let self else { return }
                captureButton.transform = .identity
            }
        }
    }
}
