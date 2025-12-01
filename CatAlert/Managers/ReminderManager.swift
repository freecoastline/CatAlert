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
    
    private let reminderService: ReminderServiceProtocol
    
    private init(service: ReminderServiceProtocol = MockReminderService.shared) {
        self.reminderService = service
        Task {
            await loadData()
        }
    }
    
    private func loadData() async {
        do {
            activeReminders = try await reminderService.fetchReminders()
            let today = Date()
            todayActivities = try await reminderService.fetchActivities(for: today)
        } catch {
            print("❌ Failed to load data: \(error)")
            activeReminders = []
            todayActivities = []
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

    func toggleReminder(id: UUID, enabled: Bool) async {
        guard let index = activeReminders.firstIndex(where: { $0.id == id }) else {
            return
        }
        activeReminders[index].isEnabled = enabled
        await NotificationManager.shared.updateNotification(for: activeReminders[index])
        saveReminders()
    }
    
    func updateReminder(_ reminder: CatReminder) async {
        guard let index = activeReminders.firstIndex(where: { $0.id == reminder.id }) else {
            return
        }
        activeReminders[index] = reminder
        await NotificationManager.shared.updateNotification(for: reminder)
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
        activeReminders = MockData.generateTestReminders()
        saveReminders()
        todayActivities = MockData.generateTestActivities()
    }
}
