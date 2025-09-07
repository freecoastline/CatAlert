//
//  CatTabbarController.swift
//  CatAlert
//
//  Created by ByteDance on 2025/9/7.
//

import Foundation
import UIKit
import SnapKit

class CatTabbarController:UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
       // tabBar.itemPositioning = .centered
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: tabBar.bounds.minY + 5, width: tabBar.bounds.width - 60, height: 40), cornerRadius: tabBar.bounds.height / 2).cgPath
        layer.shadowColor = UIColor.gray.cgColor
        layer.fillColor = UIColor.white.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        tabBar.layer.insertSublayer(layer, at: 0)
        print("tabbarView:\(view.frame) tabbar:\(tabBar.bounds)")
    }
}

