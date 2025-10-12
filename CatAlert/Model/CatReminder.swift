//
//  CatReminder.swift
//  CatAlertTests
//
//  Created by ken on 2025/9/26.
//

import Foundation

struct CatReminder:Codable {
    let id:UUID
    var catId:String
    var title:String 
    var type:CatCareType
    var createAt:Date
    var frequency:ReminderFrequency
    var isEnabled:Bool
    var scheduledTime:[ReminderTime] = []
}

struct ReminderTime: Codable {
    let minute:Int
    let hour:Int
    
    init?(minute: Int, hour: Int) {
        guard (0...59).contains(minute), (0...23).contains(hour) else {
            return nil
        }
        self.minute = minute
        self.hour = hour
    }
    
    var displayTime:String {
        String(format: "%02d:%02d", hour, minute)
    }
}

enum ReminderFrequency: Codable {
    case daily
    case weekly
    var displayname:String {
        switch self {
        case .daily:
            "每天"
        case .weekly:
            "每周"
        }
    }
}

enum CatCareType: Codable {
    case food
    case water
    case play
    
    var displayname:String {
        switch self {
        case .food:
            "喂食"
        case .water:
            "喂水"
        case .play:
            "玩耍"
        }
    }
}
