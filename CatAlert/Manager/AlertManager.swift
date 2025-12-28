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
        guard let viewController else {
            print("alert container not found!")
            return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        viewController.present(alert, animated: false)
    }
    
    
}
