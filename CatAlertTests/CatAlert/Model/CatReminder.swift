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
    var createAt:Date
    var frequency:ReminderFrequency
}

enum ReminderFrequency {
    case daily
    case weekly
}
