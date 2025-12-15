//
//  ReminderListModels.swift
//  CatAlert
//
//  Created by ken on 2025/12/12.
//

import Foundation
import IGListSwiftKit
import IGListKit

// MARK: - Section Header Model
final class ReminderSectionHeaderModel: ListDiffable {
    func diffIdentifier() -> any NSObjectProtocol {
        type.rawValue as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: (any ListDiffable)?) -> Bool {
        guard let header = object as? ReminderSectionHeaderModel else {
            return false
        }
        return type == header.type && count == header.count
    }
    
    init(type: CatCareType, count: Int) {
        self.type = type
        self.count = count
    }
    
    let type: CatCareType
    let count: Int
}

final class ReminderItemModel: ListDiffable {
    init(reminder: CatReminder) {
        self.reminder = reminder
    }
    
    func diffIdentifier() -> any NSObjectProtocol {
        reminder.id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: (any ListDiffable)?) -> Bool {
        guard let item = object as? ReminderItemModel else {
            return false
        }
        return item.reminder.catId == reminder.catId && item.reminder.id == reminder.id && item.reminder.isEnabled == reminder.isEnabled && item.reminder.scheduledTime == reminder.scheduledTime && item.reminder.type == reminder.type && item.reminder.title == item.reminder.title
    }
    
    var reminder: CatReminder
}


