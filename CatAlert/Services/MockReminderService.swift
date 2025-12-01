//
//  MockReminderService.swift
//  CatAlert
//
//  Created by ken on 2025/11/30.
//

import Foundation

class MockReminderService: ReminderServiceProtocol {
    // MARK: - Singleton
    static let shared = MockReminderService()

    // MARK: - Properties
    /// In-memory storage simulating a database
    private var reminders: [CatReminder] = []
    private var activities: [ActivityRecord] = []

    // MARK: - Init
    private init() {
        // Initialize with mock data
        reminders = MockData.generateTestReminders()
        activities = MockData.generateTestActivities()
    }

    // MARK: - ReminderServiceProtocol - Reminder Operations

    func fetchReminders() async throws -> [CatReminder] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000)  // 0.5 seconds
        return reminders
    }

    func createReminder(_ reminder: CatReminder) async throws -> CatReminder {
        // Simulate network delay (writes are slower)
        try await Task.sleep(nanoseconds: 1_000_000_000)  // 1 second

        // Add to in-memory storage
        reminders.append(reminder)

        // Return the created reminder
        return reminder
    }

    func updateReminder(_ reminder: CatReminder) async throws -> CatReminder {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 800_000_000)  // 0.8 seconds

        // Find the reminder by ID
        guard let index = reminders.firstIndex(where: { $0.id == reminder.id }) else {
            throw NSError(
                domain: "MockReminderService",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "Reminder not found with ID: \(reminder.id)"]
            )
        }

        // Update the reminder
        reminders[index] = reminder

        // Return the updated reminder
        return reminders[index]
    }

    func deleteReminder(_ id: UUID) async throws {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000)  // 0.5 seconds

        // Remove reminder from array
        reminders.removeAll { $0.id == id }
    }

    // MARK: - ReminderServiceProtocol - Activity Operations

    func fetchActivities(for date: Date) async throws -> [ActivityRecord] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000)  // 0.5 seconds

        // Filter activities for the specified date
        let calendar = Calendar.current
        let filtered = activities.filter { activity in
            calendar.isDate(activity.scheduledTime, inSameDayAs: date)
        }

        return filtered
    }

    func updateActivityStatus(_ id: UUID, status: ActivityStatus, completeTime: Date?) async throws -> ActivityRecord {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 800_000_000)  // 0.8 seconds

        // Find the activity by ID
        guard let index = activities.firstIndex(where: { $0.id == id }) else {
            throw NSError(
                domain: "MockReminderService",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "Activity not found with ID: \(id)"]
            )
        }

        // Update status and complete time
        activities[index].status = status
        activities[index].completeTime = completeTime

        // Return the updated activity
        return activities[index]
    }
}
