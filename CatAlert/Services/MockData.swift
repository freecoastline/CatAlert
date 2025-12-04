//
//  MockData.swift
//  CatAlert
//
//  Created by ken on 2025/11/30.
//

import Foundation

struct MockData {
    static let testCatId = "test_cat"
    static func generateTestReminders() -> [CatReminder] {
        let testCatId = "test_cat"
        let now = Date()
        var reminders: [CatReminder] = []

        // 1. 每日喂食提醒 - 早中晚三次
        let foodReminder1 = CatReminder(
            id: UUID().uuidString,
            catId: testCatId,
            title: "早餐时间",
            type: .food,
            createAt: now,
            frequency: .daily,
            isEnabled: true,
            scheduledTime: [ReminderTime(minute: 0, hour: 8)!]
        )
        reminders.append(foodReminder1)

        let foodReminder2 = CatReminder(
            id: UUID().uuidString,
            catId: testCatId,
            title: "午餐时间",
            type: .food,
            createAt: now,
            frequency: .daily,
            isEnabled: true,
            scheduledTime: [ReminderTime(minute: 0, hour: 12)!]
        )
        reminders.append(foodReminder2)

        let foodReminder3 = CatReminder(
            id: UUID().uuidString,
            catId: testCatId,
            title: "晚餐时间",
            type: .food,
            createAt: now,
            frequency: .daily,
            isEnabled: true,
            scheduledTime: [ReminderTime(minute: 30, hour: 18)!]
        )
        reminders.append(foodReminder3)

        // 2. 换水提醒 - 每天两次
        let waterReminder1 = CatReminder(
            id: UUID().uuidString,
            catId: testCatId,
            title: "换水提醒",
            type: .water,
            createAt: now,
            frequency: .daily,
            isEnabled: true,
            scheduledTime: [
                ReminderTime(minute: 30, hour: 9)!,
                ReminderTime(minute: 30, hour: 17)!
            ]
        )
        reminders.append(waterReminder1)

        // 3. 玩耍提醒 - 每天一次
        let playReminder1 = CatReminder(
            id: UUID().uuidString,
            catId: testCatId,
            title: "陪胡胡玩耍",
            type: .play,
            createAt: now,
            frequency: .daily,
            isEnabled: true,
            scheduledTime: [ReminderTime(minute: 0, hour: 15)!]
        )
        reminders.append(playReminder1)

        // 4. 禁用的提醒示例
        let disabledReminder = CatReminder(
            id: UUID().uuidString,
            catId: testCatId,
            title: "夜宵时间（已禁用）",
            type: .food,
            createAt: now,
            frequency: .daily,
            isEnabled: false,
            scheduledTime: [ReminderTime(minute: 0, hour: 20)!]
        )
        reminders.append(disabledReminder)
        print("✅ 已生成 \(reminders.count) 条提醒测试数据")
        return reminders
    }

    static func generateTestActivities() -> [ActivityRecord] {
        let calendar = Calendar.current
        let now = Date()
        let testReminderId = UUID()

        var activities: [ActivityRecord] = []

        // 1. 早上8:00 - 喂食（已完成）
        if let morning8 = calendar.date(bySettingHour: 8, minute: 0, second: 0, of: now) {
            var activity1 = ActivityRecord(reminderId: testReminderId, catId: testCatId, scheduleTime: morning8, type: .food)
            activity1.status = .completed
            activity1.completeTime = calendar.date(byAdding: .minute, value: 5, to: morning8)
            activities.append(activity1)
        }

        // 2. 早上9:30 - 换水（已完成）
        if let morning9 = calendar.date(bySettingHour: 9, minute: 30, second: 0, of: now) {
            var activity2 = ActivityRecord(reminderId: testReminderId, catId: testCatId, scheduleTime: morning9, type: .water)
            activity2.status = .completed
            activity2.completeTime = calendar.date(byAdding: .minute, value: 10, to: morning9)
            activities.append(activity2)
        }

        // 3. 中午12:00 - 喂食（待完成）
        if let noon = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: now) {
            let activity3 = ActivityRecord(reminderId: testReminderId, catId: testCatId, scheduleTime: noon, type: .food)
            activities.append(activity3)
        }

        // 4. 下午3:00 - 玩耍（已过期）
        if let afternoon3 = calendar.date(bySettingHour: 15, minute: 0, second: 0, of: now) {
            var activity4 = ActivityRecord(reminderId: testReminderId, catId: testCatId, scheduleTime: afternoon3, type: .play)
            activity4.status = .expired
            activities.append(activity4)
        }

        // 5. 下午5:30 - 换水（待完成）
        if let afternoon5 = calendar.date(bySettingHour: 17, minute: 30, second: 0, of: now) {
            let activity5 = ActivityRecord(reminderId: testReminderId, catId: testCatId, scheduleTime: afternoon5, type: .water)
            activities.append(activity5)
        }

        // 6. 晚上6:30 - 喂食（待完成）
        if let evening6 = calendar.date(bySettingHour: 18, minute: 30, second: 0, of: now) {
            let activity6 = ActivityRecord(reminderId: testReminderId, catId: testCatId, scheduleTime: evening6, type: .food)
            activities.append(activity6)
        }

        // 7. 晚上8:00 - 玩耍（已跳过）
        if let evening8 = calendar.date(bySettingHour: 20, minute: 0, second: 0, of: now) {
            var activity7 = ActivityRecord(reminderId: testReminderId, catId: testCatId, scheduleTime: evening8, type: .play)
            activity7.status = .skipped
            activities.append(activity7)
        }

        print("✅ 已生成 \(activities.count) 条活动测试数据")
        return activities
    }
}
