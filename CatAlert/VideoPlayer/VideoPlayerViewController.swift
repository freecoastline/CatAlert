//
//  VideoPlayerViewController.swift
//  CatAlert
//
//  Created by ken on 2025/11/4.
//


import UIKit
import AVFoundation

class VideoPlayerViewController: UIViewController {
    // MARK: - Properties
    private let player = AVPlayer()
    private let playerLayer = AVPlayerLayer()
    private let videoURL: URL
    
    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init()
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
