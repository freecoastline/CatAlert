//
//  ActivityRecord.swift
//  CatAlertTests
//
//  Created by ken on 2025/9/27.
//

import Foundation

struct ActivityRecord:Codable {
    let id: String
    let reminderId: String
    let catId: String
    let type: CatCareType
    var scheduledTime: Date
    var completeTime: Date?
    var status: ActivityStatus
    
    var typeString: String {
        switch type {
        case .food:
            "喂食"
        case .water:
            "换水"
        case .play:
            "玩耍"
        }
    }
}

extension ActivityRecord {
    init(reminderId: UUID, catId: String, scheduledTime: Date, type: CatCareType) {
        self.id = UUID().uuidString
        self.reminderId = reminderId.uuidString
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
