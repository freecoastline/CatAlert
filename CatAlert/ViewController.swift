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
        let tabbar = UITabBarController()
        let catProfile = CatProfileViewController()
        let catCurrentStatus = CatCurrentStatusViewController()
        tabbar.viewControllers = [catCurrentStatus, catProfile]
        view.addSubview(tabbar.view)
        catCurrentStatus.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "alarm.waves.left.and.right"), tag: 0)
        catProfile.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person.crop.circle"), tag: 1)
    }


}

