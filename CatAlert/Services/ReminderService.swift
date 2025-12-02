//
//  ReminderService.swift
//  CatAlert
//
//  Created by ken on 2025/12/1.
//

import Foundation

class ReminderService: ReminderServiceProtocol {
    // MARK: - Singleton
    static let shared = ReminderService()
    
    // MARK: - Property
    private let networkService: NetworkService
    
    // MARK: - Struct
    private struct ActivityStatusUpdate: Codable {
        let status: ActivityStatus
        let completeTime: Date?
    }
    
    
    // MARK: - Init
    private init(networkService: NetworkService = NetworkService.shared) {
        self.networkService = networkService
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ReminderServiceProtocol - Reminder Operations

    func fetchReminders() async throws -> [CatReminder] {
        let reminders: [CatReminder] = try await networkService.request(url: "api/reminders", method: .get, requiresAuth: true)
        return reminders
    }

    func createReminder(_ reminder: CatReminder) async throws -> CatReminder {
        let response: CatReminder = try await networkService.request(url: "api/reminders/", method: .post, body: reminder, requiresAuth: true)
        return response
    }

    func updateReminder(_ reminder: CatReminder) async throws -> CatReminder {
        let updateReminder: CatReminder = try await networkService.request(url: "api/reminders/\(reminder.id)", method: .put, body:reminder, requiresAuth: true)
        return updateReminder
    }

    private struct EmptyResponse: Codable {
        let messageDic: Dictionary<String, String>
    }
    
    func deleteReminder(_ id: UUID) async throws {
        let emptyResponse: EmptyResponse = try await networkService.request(url: "api/reminders/\(id)", method: .delete, requiresAuth: true)
    }

    // MARK: - ReminderServiceProtocol - Activity Operations

    func fetchActivities(for date: Date) async throws -> [ActivityRecord] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        let activityRecords: [ActivityRecord] = try await networkService.request(url: "api/activities/" + dateString, method: .get, requiresAuth: true)
        return activityRecords
    }
    
    func updateActivityStatus(_ id: UUID, status: ActivityStatus, completeTime: Date?) async throws -> ActivityRecord {
        let activityStatusUpdate = ActivityStatusUpdate(status: status, completeTime: completeTime)
        let updateActivity: ActivityRecord = try await networkService.request(url: "api/reminders/\(id)", method: .put, body: activityStatusUpdate, requiresAuth: true)
        return updateActivity
    }
}
