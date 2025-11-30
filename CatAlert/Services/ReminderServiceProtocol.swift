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
    
    func deleteReminder(_ id: UUID) async throws
    
    // MARK: - 
}
