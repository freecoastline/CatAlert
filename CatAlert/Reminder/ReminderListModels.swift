//
//  ReminderListModels.swift
//  CatAlert
//
//  Created by ken on 2025/12/12.
//

import Foundation
import IGListSwiftKit

// MARK: - Section Header Model
struct ReminderSectionHeaderModel: Hashable {
    let type: CatCareType
    let count: Int
}

struct ReminderItemModel: Hashable {
    static func == (lhs: ReminderItemModel, rhs: ReminderItemModel) -> Bool {
        return lhs.reminder.id == rhs.reminder.id && lhs.reminder.title == rhs.reminder.title && lhs.reminder.scheduledTime == rhs.reminder.scheduledTime && lhs.reminder.isEnabled == rhs.reminder.isEnabled
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(reminder.id)
    }
    
    var reminder: CatReminder
}


