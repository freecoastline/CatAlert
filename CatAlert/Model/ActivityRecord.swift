//
//  ActivityRecord.swift
//  CatAlertTests
//
//  Created by ken on 2025/9/27.
//

import Foundation

struct ActivityRecord:Codable {
    let id: UUID
    let reminderId: UUID
    let catId: String
    let type: CatCareType
    var scheduledTime: Date
    var completeTime: Date?
    var status: ActivityStatus
    
    var typeString: String {
        switch type {
        case .food:
            "food"
        case .water:
            "water"
        case .play:
            "play"
        }
    }
}

extension ActivityRecord {
    init(reminderId: UUID, catId: String, scheduledTime: Date, type: CatCareType) {
        self.id = UUID()
        self.reminderId = reminderId
        self.catId = catId
        self.scheduledTime = scheduledTime
        self.type = type
        self.status = .pending
        self.completeTime = nil
    }
}

enum ActivityStatus:Codable {
    case completed
    case skipped
    case expired
    case pending
}
