//
//  AppError.swift
//  CatAlert
//
//  Created by ken on 2025/12/19.
//

import Foundation

enum AppError {
    case reminderCreationFailed
    case reminderFetchFailed
    case reminderToggleFailed
    case activityUpdateFailed
    case networkError
    case unknownError

    var userMessage: String {
        switch self {
        case .reminderCreationFailed:
            return "无法保存提醒，请稍后重试"
        case .reminderFetchFailed:
            return "无法加载提醒列表，请检查网络连接"
        case .reminderToggleFailed:
            return "无法更新提醒状态，请稍后重试"
        case .activityUpdateFailed:
            return "无法更新活动状态，请稍后重试"
        case .networkError:
            return "网络连接失败，请检查网络设置"
        case .unknownError:
            return "发生未知错误，请稍后重试"
        }
    }
}
