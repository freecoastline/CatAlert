//
//  EditReminderViewController.swift
//  CatAlert
//
//  Created by ken on 2025/9/26.
//

import Foundation
import UIKit

class EditReminderViewController: UIViewController {
    private let reminder: CatReminder
    init(reminder: CatReminder) {
        self.reminder = reminder
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
