//
//  ViewController.swift
//  CatAlert
//
//  Created by ByteDance on 2025/9/6.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let catTabbar = CatTabBarController()
        view.addSubview(catTabbar.view)
        addChild(catTabbar)
    }
}

