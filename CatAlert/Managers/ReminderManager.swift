//
//  ReminderManager.swift
//  CatAlertTests
//
//  Created by ken on 2025/9/27.
//

import Foundation
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
        saveReminders()
    }
    
    func deleteReminder(id: UUID) {
        guard activeReminders.contains(where: { $0.id == id }) else {
            return
        }
        activeReminders.removeAll { $0.id == id }
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
    
}
