//
//  PhotoEditViewController.swift
//  CatAlert
//
//  Created by ken on 2025/12/31.
//

import Foundation
import UIKit

class PhotoEditViewController: UIViewController {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
    }
    
    // MARK: - Properties
    private let originalImage: UIImage
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .black
        return iv
    }()
    
    init(originalImage: UIImage) {
        self.originalImage = originalImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
