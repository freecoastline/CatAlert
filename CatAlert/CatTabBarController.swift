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
    private let tabBarVerticalOffset: CGFloat = -10
    private let tabBarHorizontalInset: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: tabBarHorizontalInset, y: tabBar.bounds.minY + tabBarVerticalOffset, width: tabBar.bounds.width - tabBarHorizontalInset * 2, height: customTabBarHeight), cornerRadius: customTabBarHeight / 2).cgPath
        layer.shadowColor = UIColor.gray.cgColor
        layer.fillColor = UIColor.white.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        tabBar.layer.insertSublayer(layer, at: 0)
        
        let catProfile = CatNewProfileViewController()
        let catCurrentStatus = CatCurrentStatusViewController()
        let reminderSettingsPage = ReminderSettingsViewController()

        // 将设置页包装到 NavigationController 中，以支持导航栏和页面跳转
        let reminderNavController = UINavigationController(rootViewController: reminderSettingsPage)

        catCurrentStatus.tabBarItem = UITabBarItem(title: "提醒", image: UIImage(systemName: "alarm.waves.left.and.right"), tag: 2)
        reminderNavController.tabBarItem = UITabBarItem(title: "设置", image: UIImage(systemName: "gear"), tag: 1)
        catProfile.tabBarItem = UITabBarItem(title: "个人", image: UIImage(systemName: "person.crop.circle"), tag: 0)
        viewControllers = [catProfile, catCurrentStatus, reminderNavController]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = customTabBarHeight
        tabBar.frame = tabBarFrame
    }
}

