//
//  ReminderSectionController.swift
//  CatAlert
//
//  Created by ken on 2025/12/12.
//

import Foundation
import IGListKit

final class ReminderSectionController: ListSectionController {
    // MARK: - Properties
    private var reminderItem: ReminderItemModel?
    
    // MARK: - LifeCycle
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)
    }
    
    // MARK: - IGList Methods
    override func didUpdate(to object: Any) {
        reminderItem = object as? ReminderItemModel
    }
    
}
