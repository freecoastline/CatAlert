//
//  TaskProgress.swift
//  CatAlert
//
//  Created by ken on 2025/9/30.
//

import Foundation

struct TaskProgress {
    let totalTasks: Int         // 今日总任务数
    let completedTasks: Int     // 已完成任务数
    let overdueTasks: Int       // 过期任务数
    let upcomingTasks: Int      // 即将到期任务数 (1小时内)

    // 计算属性
    var completionRate: Double {
        guard totalTasks > 0 else { return 0.0 }
        return Double(completedTasks) / Double(totalTasks)
    }

    var hasOverdue: Bool {
        return overdueTasks > 0
    }

    var isAllCompleted: Bool {
        return totalTasks > 0 && completedTasks == totalTasks
    }
}
