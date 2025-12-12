//
//  EditReminderViewController.swift
//  CatAlert
//
//  Created by ken on 2025/9/26.
//

import Foundation
import UIKit

class EditReminderViewController: UIViewController {
    private var reminder: CatReminder?
    init(reminder: CatReminder? = nil) {
        self.reminder = reminder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
