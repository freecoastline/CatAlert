//
//  CatStatusItem.swift
//  CatAlert
//
//  Created by ken on 2025/12/6.
//

import Foundation

enum CatStatusItem: Hashable {
    case catInfo(CatSimpleInfoModel)
    case activity(ActivityRecord)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .catInfo(let model):
            hasher.combine("catInfo")
            hasher.combine(model.name)
        case .activity(let activity):
            hasher.combine("activity")
            hasher.combine(activity.id)
            hasher.combine(activity.status)
        }
    }
    
    static func == (lhs: CatStatusItem, rhs: CatStatusItem) -> Bool {
        switch(lhs, rhs) {
        case (.catInfo(let l), .catInfo(let r)):
            return l.name == r.name
        case (.activity(let l), .activity(let r)):
            return l.id == r.id && l.status == r.status
        default:
            return false
        }
    }
}
