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
        let catTabbar = CatTabbarController()
        let catProfile = CatProfileViewController()
        let catCurrentStatus = CatCurrentStatusViewController()
        catTabbar.viewControllers = [catCurrentStatus, catProfile]
        view.addSubview(catTabbar.view)
        catCurrentStatus.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "alarm.waves.left.and.right"), tag: 0)
        catProfile.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person.crop.circle"), tag: 1)
    }
}

