//
//  NotificationManager.swift
//  CatAlertTests
//
//  Created by ken on 2025/9/27.
//
import UIKit
import UserNotifications

class NotificationManager {
    // 核心职责:
    // 1. 请求通知权限
    // 2. 调度/取消本地通知
    // 3. 处理通知响应
    // 4. 管理通知设置
    static let shared = NotificationManager()
    private let center = UNUserNotificationCenter.current()
    private init() {}
    
    func requestNotificationPermission(completion: @escaping (Bool) -> Void ) {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("request authorization success")
            } else if let error {
                print("request authorization error: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func checkAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    func scheduleNotification(for reminder: CatReminder) {
        guard reminder.isEnabled else {
            return
        }
        for scheduledTime in reminder.scheduledTime {
            let minute = scheduledTime.minute
            let hour = scheduledTime.hour
            var dateComponents = DateComponents()
            dateComponents.minute = minute
            dateComponents.hour = hour
            
            let mutableContent = UNMutableNotificationContent()
            mutableContent.title = reminder.title
            mutableContent.body = getNotificationMessage(for: reminder.type)
            mutableContent.sound = .default
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            // 使用 uuidString 而不是 uuid
            let identifier = "\(reminder.id.uuidString)_\(hour)_\(minute)"
            let request = UNNotificationRequest(identifier: identifier, content: mutableContent, trigger: trigger)
            
            center.add(request) { error in
                if let error = error {
                    print("调度通知失败: \(error.localizedDescription)")
                } else {
                    print("通知已调度: \(identifier)")
                }
            }
        }
    }
    
    func cancelNotification(for reminderId: UUID) async {
        let notifications = await UNUserNotificationCenter.current().pendingNotificationRequests()
        center.removePendingNotificationRequests(withIdentifiers: notifications.filter { $0.identifier.hasPrefix(reminderId.uuidString)}
            .map(\.identifier)
        )
    }
    
    func handleNotificationResponse(_ response: UNNotificationResponse) {
        
    }
    
    // MARK: - Private Helper Methods
    
    private func getNotificationMessage(for careType: CatCareType) -> String {
        switch careType {
        case .food:
            return "🍽️ 喵星人的用餐时间到啦！别忘了给小主子准备美食哦～"
        case .water:
            return "💧 该给猫咪换新鲜的水啦！保持充足的水分对健康很重要呢～"
        case .play:
            return "🎾 和你的猫咪互动玩耍的时间！一起享受快乐的游戏时光吧～"
        }
    }
}
