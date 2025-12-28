//
//  AlertManager.swift
//  CatAlert
//
//  Created by ken on 2025/12/27.
//

import Foundation
import UIKit

class AlertManager {
    // MARK: - Singleton
    static let shared = AlertManager()
    private init(){}
    
    func showAlert(_ message: String, title: String = "Error", on viewController: UIViewController?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        if let viewController {
            viewController.present(alert, animated: false)
        } else {
            if let topVC = getTopViewController() {
                topVC.present(alert, animated: false)
            } else {
                print("alert container not found!")
            }
        }
    }
    
    // MARK: - Helper Methods
    private func getTopViewController() -> UIViewController? {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }
        
        guard let window = scene.windows.first(where: { $0.isKeyWindow }) else {
            return nil
        }
        
        guard let rootViewController = window.rootViewController else {
            return nil
        }
        return getTopViewController(from: rootViewController)
    }
    
    private func getTopViewController(from vc: UIViewController) -> UIViewController? {
        if let viewController = vc.presentedViewController {
            return getTopViewController(from: viewController)
        }
        
        if let navigationViewController = vc as? UINavigationController,
           let topVC = navigationViewController.topViewController {
            return getTopViewController(from: topVC)
        }
        
        if let tabbarController = vc as? UITabBarController,
           let selectedViewController = tabbarController.selectedViewController {
            return getTopViewController(from: selectedViewController)
        }
        
        return vc
    }
}
