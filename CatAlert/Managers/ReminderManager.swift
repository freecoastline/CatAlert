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
    
    private init(service: ReminderServiceProtocol = ReminderService.shared) {
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
    func fetchReminders() async throws -> [CatReminder] {
        let reminders = try await reminderService.fetchReminders()
        activeReminders = reminders
        return reminders
    }
    
    func createReminder(_ reminder: CatReminder) async throws {
        let savedReminder = try await reminderService.createReminder(reminder)
        activeReminders.append(savedReminder)
        NotificationManager.shared.scheduleNotification(for: savedReminder)
    }
    
    func deleteReminder(id: String) async throws {
        try await reminderService.deleteReminder(id)
        activeReminders.removeAll { $0.id == id }
        await NotificationManager.shared.cancelNotification(for: id)
    }

    func toggleReminder(id: String, enabled: Bool) async throws {
        guard let index = activeReminders.firstIndex(where: { $0.id == id }) else {
            return
        }
        var updateReminder = activeReminders[index]
        updateReminder.isEnabled = enabled
        let updatedReminder = try await reminderService.updateReminder(updateReminder)
        activeReminders[index] = updatedReminder
        await NotificationManager.shared.updateNotification(for: updatedReminder)
    }
    
    func updateReminder(_ reminder: CatReminder) async throws {
        let updateReminder = try await reminderService.updateReminder(reminder)
        guard let index = activeReminders.firstIndex(where: { $0.id == updateReminder.id }) else {
            return
        }
        activeReminders[index] = updateReminder
        await NotificationManager.shared.updateNotification(for: updateReminder)
    }
    
    func markActivityCompleted(id: String) async throws {
        let updateActivity = try await reminderService.updateActivityStatus(id, status: .completed, completeTime: Date())
        guard let index = todayActivities.firstIndex(where: { $0.id == id}) else {
            return
        }
        todayActivities[index] = updateActivity
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
    
    func refreshTodayData() async throws {
        let today = Date()
        todayActivities = try await ReminderService.shared.fetchActivities(for: today)
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
            case .pending where record.scheduleTime < oneHourLater && record.scheduleTime > now :
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
    func generateTestData() async {
        activeReminders = MockData.generateTestReminders()
        for reminder in activeReminders {
            try? await reminderService.createReminder(reminder)
        }
        todayActivities = MockData.generateTestActivities()
    }
}
