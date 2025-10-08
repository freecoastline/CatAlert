//
//  CatTabbarController.swift
//  CatAlert
//
//  Created by ByteDance on 2025/9/7.
//

import Foundation
import UIKit
import SnapKit

class CatTabBarController:UITabBarController {
    private let customTabBarHeight:CGFloat = 60.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: tabBar.bounds.minY - 10, width: tabBar.bounds.width - 60, height: customTabBarHeight), cornerRadius: customTabBarHeight / 2).cgPath
        layer.shadowColor = UIColor.gray.cgColor
        layer.fillColor = UIColor.white.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        tabBar.layer.insertSublayer(layer, at: 0)
        
        let catProfile = CatProfileViewController()
        let catCurrentStatus = CatCurrentStatusViewController()
        let reminderSettingsPage = ReminderSettingsViewController()
        
        catCurrentStatus.tabBarItem = UITabBarItem(title: "提醒", image: UIImage(systemName: "alarm.waves.left.and.right"), tag: 0)
        reminderSettingsPage.tabBarItem = UITabBarItem(title: "设置", image: UIImage(systemName: "gear"), tag: 1)
        catProfile.tabBarItem = UITabBarItem(title: "个人", image: UIImage(systemName: "person.crop.circle"), tag: 2)
        viewControllers = [catCurrentStatus, reminderSettingsPage, catProfile]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = customTabBarHeight
        tabBar.frame = tabBarFrame
    }
}

