//
//  VideoPlayerViewController.swift
//  CatAlert
//
//  Created by ken on 2025/11/4.
//


import UIKit
import AVFoundation
import AVKit

class VideoPlayerViewController: UIViewController {
    // MARK: - Properties
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private let videoURL: URL
    private let closeButtonHeight: CGFloat =  40.0
    private let playPauseButtonHeight: CGFloat = 60.0
    
    // MARK: - Init
    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
        setupUI()
    }
    
    // MARK: - UI Components
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.layer.cornerRadius = closeButtonHeight / 2
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.layer.cornerRadius = playPauseButtonHeight / 2
        button.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Selector
    @objc private func closeButtonTapped() {
        
    }
    
    @objc private func playPauseButtonTapped() {
        
    }
    
    
    @objc private func playerDidEndPlaying() {
        
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.addSubview(closeButton)
        view.addSubview(playPauseButton)
        
        closeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.width.equalTo(40)
        }
        
        playPauseButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalToSuperview()
        }
    }
    
    private func setupPlayer() {
        player = AVPlayer(url: videoURL)
        
        playerLayer = AVPlayerLayer(player: player)
        
        if let playerLayer {
            playerLayer.videoGravity = .resizeAspect
            playerLayer.frame = view.bounds
            view.layer.addSublayer(playerLayer)
        }
        
        player?.play()
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidEndPlaying), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }
    
    
}
