//
//  CameraSessionManager.swift
//  CatAlert
//
//  Created by ken on 2025/12/25.
//

import Foundation
import AVFoundation

class CameraSessionManager {
    // MARK: - Singleton
    static let shared = CameraSessionManager()
    private init(){
        session = AVCaptureSession()
        sessionQueue = DispatchQueue(label: "com.catAlert.camera.session")
    }
    
    // MARK: - Properties
    let session: AVCaptureSession
    private var videoDeviceInput: AVCaptureDeviceInput?
    private let photoOutput: AVCapturePhotoOutput
    private let sessionQueue: DispatchQueue
    
    
    
}
