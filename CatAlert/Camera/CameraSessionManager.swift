//
//  CameraSessionManager.swift
//  CatAlert
//
//  Created by ken on 2025/12/25.
//

import Foundation
import AVFoundation

class CameraSessionManager {
    enum CameraError: Error {
        case deviceNotFound
        case configurationFailed
        // Add more as needed
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
    
    func requestCameraPermission() async -> Bool {
        await AVCaptureDevice.requestAccess(for: .video)
    }
    
    func setupCamera() async throws {
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            throw CameraError.deviceNotFound
        }
        
        
                
    }
    
    
    
    
}
