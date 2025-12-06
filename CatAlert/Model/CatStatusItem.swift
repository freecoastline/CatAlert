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
    
    
}
