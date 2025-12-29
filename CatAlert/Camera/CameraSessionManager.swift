//
//  CameraSessionManager.swift
//  CatAlert
//
//  Created by ken on 2025/12/25.
//

import Foundation
import AVFoundation
import UIKit

class CameraSessionManager: NSObject {
    enum CameraError: Error {
        case deviceNotFound
        case configurationFailed
        var localizedDescription: String {
            switch self {
            case .deviceNotFound:
                return "Camera device not available"
            case .configurationFailed:
                return "Failed to configure camera"
            }
        }
    }
    
    // MARK: - Singleton
    static let shared = CameraSessionManager()
    private init(){
        session = AVCaptureSession()
        sessionQueue = DispatchQueue(label: "com.catAlert.camera.session")
        photoOutput = AVCapturePhotoOutput()
    }
    
    // MARK: - Properties
    let session: AVCaptureSession
    private var videoDeviceInput: AVCaptureDeviceInput?
    private let photoOutput: AVCapturePhotoOutput
    private let sessionQueue: DispatchQueue
    private var photoCaptureCompletion: ((Result<UIImage, Error>) -> Void)?
    
    // MARK: - Helper methods
    func requestCameraPermission() async -> Bool {
        await AVCaptureDevice.requestAccess(for: .video)
    }
    
    func setupCamera() async throws {
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            throw CameraError.deviceNotFound
        }
        
        let input = try AVCaptureDeviceInput(device: camera)
        
        await withCheckedContinuation { continuation in
            sessionQueue.async { [weak self] in
                guard let self else {
                    continuation.resume()
                    return
                }
                session.beginConfiguration()
                if session.canAddInput(input) {
                    session.addInput(input)
                    videoDeviceInput = input
                }
                if session.canAddOutput(photoOutput) {
                    session.addOutput(photoOutput)
                }
                    
                session.commitConfiguration()
                continuation.resume()
            }
        }
    }
    
    func startSession() {
        sessionQueue.async { [weak self] in
            guard let self else { return }
            if !session.isRunning {
                session.startRunning()
            }
        }
    }
    
    
    func stopSession() {
        sessionQueue.async { [weak self] in
            guard let self else { return }
            if session.isRunning {
                session.stopRunning()
            }
        }
    }
    
    func capturePhoto(completion: @escaping (Result<UIImage, Error>) -> Void) {
        self.photoCaptureCompletion = completion
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = .auto
        photoSettings.isHighResolutionPhotoEnabled = true
        sessionQueue.async { [weak self] in
            guard let self else { return }
            photoOutput.capturePhoto(with: photoSettings, delegate: self)
        }
    }
    
    func checkCameraPermission() async {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            let granted = await requestCameraPermission()
            if granted {
                do {
                    try await setupCamera()
                } catch {
                    //
                }
            }
        case .denied, .restricted:
//            showErrorAlert("请在设置中允许相机权限")
        case .authorized:
            do {
                try await setupCamera()
            } catch {
                await MainActor.run {
//                    showErrorAlert("相机设置失败")
                }
            }
        @unknown default:
            break
        }
    }
}

extension CameraSessionManager: AVCapturePhotoCaptureDelegate {
    
}
