//
//  CatReminder.swift
//  CatAlertTests
//
//  Created by ken on 2025/9/26.
//

import Foundation

struct CatReminder {
    let id:UUID
    var catId:String
    var title:String
    var type:CatCareType
    var createAt:Date
    var frequency:ReminderFrequency
    var isEnabled:Bool
    var scheduledTime:[ReminderTime] = []
}

struct ReminderTime {
    let minute:Int
    let hour:Int
    
    init?(minute: Int, hour: Int) {
        guard (0...59).contains(minute), (0...24).contains(hour) else {
            return nil
        }
        self.minute = minute
        self.hour = hour
    }
}

enum ReminderFrequency {
    case daily
    case weekly
}

enum CatCareType {
    case food
    case water
    case play
}
