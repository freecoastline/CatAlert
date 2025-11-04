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
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private let videoURL: URL
    private let closeButtonHeight: CGFloat =  40.0
    
    // MARK: - Init
    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.layer.cornerRadius = closeButtonHeight / 2
        return button
    }()
    
    
    
}
