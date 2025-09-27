//
//  ActivityCard.swift
//  CatAlertTests
//
//  Created by ken on 2025/9/27.
//

import Foundation

struct ActivityCard {
    let id: UUID
    let reminderId: UUID
    let catId: String
    let type: CatCareType
    let sheduledTime: Date
    let completeTime: Date?
    let status: ActivityStatus
}

enum ActivityStatus {
    case finished
    case unfinished
    case expired
}
