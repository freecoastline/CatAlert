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
    
    // 创建新提醒
    func createReminder(_ reminder: CatReminder) {
        activeReminders.append(reminder)
    }
    // 更新提醒
    func updateReminder(_ reminder: CatReminder) {
        
    }
    
    // 删除提醒
    func deleteReminder(id: UUID) {
        activeReminders.removeAll { reminder in
            reminder.id == id
        }
    }
    
    // 启用/禁用
    func toggleReminder(id: UUID, enabled: Bool) {
        if let index = activeReminders.firstIndex(where: { $0.id == id }) {
            activeReminders[index].isEnabled = enabled
        }
    }
    
    // 标记完成
    func markActivityCompleted(id: UUID, notes: String?) {
        if let index = todayActivities.firstIndex(where: { $0.id == id}) {
            todayActivities[index].status = .completed
            todayActivities[index].completeTime = Date()
        }
    }
    
    // 获取今日待办
    func getTodayPendingActivities() -> [ActivityRecord] {
        todayActivities
    }
    
    // 获取即将到期提醒
    func getUpcomingReminders() -> [CatReminder] {
        activeReminders
    }
}
