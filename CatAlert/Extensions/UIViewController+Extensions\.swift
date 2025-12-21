//
//  UIViewController+Extensions\.swift
//  CatAlert
//
//  Created by ken on 2025/12/21.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorAlert(_ message: String, title: String = "错误") {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "确定", style: .default))
        present(vc, animated: true)
    }
    
     func showSuccessAlert(_ message: String, title: String = "成功") {
         let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "确定", style: .default))
         present(alert, animated: true)
     }
}

