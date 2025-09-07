//
//  ViewController.swift
//  CatAlert
//
//  Created by ByteDance on 2025/9/6.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let catTabbar = CatTabbarController()
        let catProfile = CatProfileViewController()
        let catCurrentStatus = CatCurrentStatusViewController()
        catTabbar.viewControllers = [catCurrentStatus, catProfile]
        view.addSubview(catTabbar.view)
        catCurrentStatus.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "alarm.waves.left.and.right"), tag: 0)
        catProfile.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        if let items = catTabbar.tabBar.items {
            for item in items {
                item.imageInsets = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
            }
        }
    }
}

