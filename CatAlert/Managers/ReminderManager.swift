//
//  ReminderManager.swift
//  CatAlertTests
//
//  Created by ken on 2025/9/27.
//

import Foundation
import Combine

class ReminderManager: ObservableObject {
    static let shared = ReminderManager()
    
    @Published var activeReminders: [CatReminder] = []
    @Published var todayActivities: [ActivityRecord] = []
    
    // 核心方法：
    private init() {
        loadData()
    }
    
    private func loadData() {
        activeReminders = loadReminders()
        let activities = loadActivityRecords()
        let todayStartTime = Calendar.current.startOfDay(for: Date())
        guard let tomorrowStartTime = Calendar.current.date(byAdding: .day, value: 1, to: todayStartTime) else {
            return
        }
        todayActivities = activities.filter({
            (todayStartTime..<tomorrowStartTime).contains($0.scheduledTime)
        })
    }
    
// MARK: - Private Persistence
    private func saveReminders() {
        do {
            try DataPersistenceManager.shared.saveData(activeReminders, to: "reminders.json")
        } catch {
            print("Failed to save reminders: \(error)")
        }
    }
    
    private func loadReminders() -> [CatReminder] {
        do {
            return try DataPersistenceManager.shared.loadData(CatReminder.self, from: "reminders.json")
        } catch {
            print("Failed to load reminders: \(error)")
            return []
        }
    }

    private func saveActivityRecords() {
        do {
            try DataPersistenceManager.shared.saveData(todayActivities, to: "activity_records.json")
        } catch {
            print("Failed to save activities: \(error)")
        }
    }
    
    private func loadActivityRecords() -> [ActivityRecord] {
        do {
            return try DataPersistenceManager.shared.loadData(ActivityRecord.self, from: "activity_records.json")
        } catch {
            print("Failed to load activities: \(error)")
            return []
        }
    }
    
// MARK: - Public API
    func createReminder(_ reminder: CatReminder) {
        activeReminders.append(reminder)
        NotificationManager.shared.scheduleNotification(for: reminder)
        saveReminders()
    }
    
    func deleteReminder(id: UUID) async {
        guard activeReminders.contains(where: { $0.id == id }) else {
            return
        }
        activeReminders.removeAll { $0.id == id }
        await NotificationManager.shared.cancelNotification(for: id)
        saveReminders()
    }

    func toggleReminder(id: UUID, enabled: Bool) {
        guard let index = activeReminders.firstIndex(where: { $0.id == id }) else {
            return
        }
        activeReminders[index].isEnabled = enabled
        saveReminders()
    }
    
    func updateReminder(_ reminder: CatReminder) {
        guard let index = activeReminders.firstIndex(where: { $0.id == reminder.id }) else {
            return
        }
        activeReminders[index] = reminder
        saveReminders()
    }
    
    func markActivityCompleted(id: UUID) {
        guard let index = todayActivities.firstIndex(where: { $0.id == id}) else {
            return
        }
        todayActivities[index].status = .completed
        todayActivities[index].completeTime = Date()
        saveActivityRecords()
    }
    
    func getUpcomingReminders() -> [CatReminder] {
        let now = Date()
        let calendar = Calendar.current
        guard let oneHourLater = calendar.date(byAdding: .hour, value: 1, to: now) else {
            return []
        }
        return activeReminders.filter { reminder in
            guard reminder.isEnabled else {
                return false
            }
            return reminder.scheduledTime.contains(where: { reminderTime in
                for dayOffset in 0...1 {
                    guard let targetDay = calendar.date(byAdding: .day, value: dayOffset, to: calendar.startOfDay(for: now)) else {
                        continue
                    }
                    guard let scheduledTime = calendar.date(bySettingHour: reminderTime.hour, minute: reminderTime.minute, second: 0, of: targetDay) else {
                        continue
                    }
                    if (now..<oneHourLater).contains(scheduledTime) {
                        return true
                    }
                }
                return false
            })
        }
    }
}


extension ReminderManager {
    func calculateTodayProgress() -> TaskProgress {
        let now = Date()
        let calendar = Calendar.current

        var completed = 0, expired = 0, upcoming = 0
        let oneHourLater = calendar.date(byAdding: .hour, value: 1, to: now) ?? now
        todayActivities.forEach { record in
            switch record.status {
            case .completed:
                completed += 1
            case .expired:
                expired += 1
            case .pending where record.scheduledTime < oneHourLater && record.scheduledTime > now :
                upcoming += 1
            default: break
            }
        }

        return TaskProgress(
            totalTasks: todayActivities.count,
            completedTasks: completed,
            overdueTasks: expired,
            upcomingTasks: upcoming
        )
    }

    // MARK: - Test Data Generation
    func generateTestData() {
        generateTestReminders()
        generateTestActivities()
    }

    private func generateTestReminders() {
        let testCatId = "test_cat"
        let now = Date()
        var reminders: [CatReminder] = []

        // 1. 每日喂食提醒 - 早中晚三次
        let foodReminder1 = CatReminder(
            id: UUID(),
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
            id: UUID(),
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
            id: UUID(),
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
            id: UUID(),
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
            id: UUID(),
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
            id: UUID(),
            catId: testCatId,
            title: "夜宵时间（已禁用）",
            type: .food,
            createAt: now,
            frequency: .daily,
            isEnabled: false,
            scheduledTime: [ReminderTime(minute: 0, hour: 20)!]
        )
        reminders.append(disabledReminder)

        activeReminders = reminders
        saveReminders()
        print("✅ 已生成 \(reminders.count) 条提醒测试数据")
    }

    private func generateTestActivities() {
        let calendar = Calendar.current
        let now = Date()
        let testReminderId = UUID()
        let testCatId = "test_cat"

        var activities: [ActivityRecord] = []

        // 1. 早上8:00 - 喂食（已完成）
        if let morning8 = calendar.date(bySettingHour: 8, minute: 0, second: 0, of: now) {
            var activity1 = ActivityRecord(reminderId: testReminderId, catId: testCatId, scheduledTime: morning8, type: .food)
            activity1.status = .completed
            activity1.completeTime = calendar.date(byAdding: .minute, value: 5, to: morning8)
            activities.append(activity1)
        }

        // 2. 早上9:30 - 换水（已完成）
        if let morning9 = calendar.date(bySettingHour: 9, minute: 30, second: 0, of: now) {
            var activity2 = ActivityRecord(reminderId: testReminderId, catId: testCatId, scheduledTime: morning9, type: .water)
            activity2.status = .completed
            activity2.completeTime = calendar.date(byAdding: .minute, value: 10, to: morning9)
            activities.append(activity2)
        }

        // 3. 中午12:00 - 喂食（待完成）
        if let noon = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: now) {
            let activity3 = ActivityRecord(reminderId: testReminderId, catId: testCatId, scheduledTime: noon, type: .food)
            activities.append(activity3)
        }

        // 4. 下午3:00 - 玩耍（已过期）
        if let afternoon3 = calendar.date(bySettingHour: 15, minute: 0, second: 0, of: now) {
            var activity4 = ActivityRecord(reminderId: testReminderId, catId: testCatId, scheduledTime: afternoon3, type: .play)
            activity4.status = .expired
            activities.append(activity4)
        }

        // 5. 下午5:30 - 换水（待完成）
        if let afternoon5 = calendar.date(bySettingHour: 17, minute: 30, second: 0, of: now) {
            let activity5 = ActivityRecord(reminderId: testReminderId, catId: testCatId, scheduledTime: afternoon5, type: .water)
            activities.append(activity5)
        }

        // 6. 晚上6:30 - 喂食（待完成）
        if let evening6 = calendar.date(bySettingHour: 18, minute: 30, second: 0, of: now) {
            let activity6 = ActivityRecord(reminderId: testReminderId, catId: testCatId, scheduledTime: evening6, type: .food)
            activities.append(activity6)
        }

        // 7. 晚上8:00 - 玩耍（已跳过）
        if let evening8 = calendar.date(bySettingHour: 20, minute: 0, second: 0, of: now) {
            var activity7 = ActivityRecord(reminderId: testReminderId, catId: testCatId, scheduledTime: evening8, type: .play)
            activity7.status = .skipped
            activities.append(activity7)
        }

        todayActivities = activities
        print("✅ 已生成 \(activities.count) 条活动测试数据")
    }
}
