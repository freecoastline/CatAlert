//
//  ReminderServiceProtocol.swift
//  CatAlert
//
//  Created by ken on 2025/11/30.
//

import Foundation

protocol ReminderServiceProtocol {
    // MARK: - ReminderOperations
    func fetchReminders() async throws -> [CatReminder]
    
    func createReminder(_ reminder: CatReminder) async throws -> CatReminder
    
    func updateReminder(_ reminder: CatReminder) async throws -> CatReminder
    
    func deleteReminder(_ id: String) async throws
    
    // MARK: - Activity Operations
    func fetchActivities(for date: Date) async throws -> [ActivityRecord]
    
    func updateActivityStatus(_ id: String, status: ActivityStatus, completeTime: Date?) async throws -> ActivityRecord
}
