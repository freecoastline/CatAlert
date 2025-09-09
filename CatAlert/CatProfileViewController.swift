//
//  CatProfileViewController.swift
//  CatAlert
//
//  Created by ByteDance on 2025/9/7.
//

import Foundation
import UIKit

class CatProfileViewController:UIViewController {
    lazy var infoView = CatInfoHalfView(frame: CGRect(x: 0, y: 200, width: view.bounds.width, height: view.bounds.height - 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    
    func setupUI() {
        setupBackGround()
        view.addSubview(infoView)
    }
    
    func setupBackGround() {
        let backgroundImageView = UIImageView(frame: self.view.bounds)
        let filePath = try Bundle.main.path(forResource: "PinkbackGround", ofType: "webp")
        guard let filePath else {
            backgroundImageView.backgroundColor = .systemPink
            view.insertSubview(backgroundImageView, at: 0)
            return
        }
        if let image = UIImage(contentsOfFile: filePath) {
            backgroundImageView.image = image
        } else {
            backgroundImageView.backgroundColor = .systemPink
        }
        backgroundImageView.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImageView, at: 0)
    }
    
}
