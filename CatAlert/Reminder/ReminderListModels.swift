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

struct ReminderItemModel: Hashable {
    static func == (lhs: ReminderItemModel, rhs: ReminderItemModel) -> Bool {
        return lhs.reminder.id == rhs.reminder.id && lhs.reminder.title == rhs.reminder.title && lhs.reminder.scheduledTime == rhs.reminder.scheduledTime && lhs.reminder.isEnabled == rhs.reminder.isEnabled
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(reminder.id)
        hasher.combine(reminder.isEnabled)
        hasher.combine(reminder.title)
        hasher.combine(reminder.scheduledTime)
    }
    
    var reminder: CatReminder
}


