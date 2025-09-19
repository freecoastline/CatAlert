//
//  CatDailyCareViewController.swift
//  CatAlert
//
//  Created by ken on 2025/9/19.
//

import Foundation
import UIKit

class CatDailyCareViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .green
        if let superView = view.superview {
            view.frame = superView.bounds
        }
    }
}
