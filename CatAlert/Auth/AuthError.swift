//
//  AuthError.swift
//  CatAlert
//
//  Created by ken on 2025/11/11.
//

import Foundation

enum AuthError:Error {
    // 网络相关
    case networkError(String)      // 网络连接失败，带错误信息
    case timeout                   // 请求超时

    // 验证码相关
    case invalidVerificationCode   // 验证码错误
    case verificationCodeExpired   // 验证码过期
    case sendCodeTooFrequently     // 发送太频繁

    // 手机号相关
    case invalidPhoneNumber        // 手机号格式错误
    case phoneNotRegistered        // 手机号未注册

    // Token 相关
    case tokenExpired              // Token 过期
    case tokenInvalid              // Token 无效

    // 服务器相关
    case serverError(Int)          // 服务器错误，带错误码

    // 通用
    case unknown(String)           // 未知错误，带错误信息
    
    
    var localizedDescription: String {
        switch self {
        case .networkError(let message):
            return "网络错误：\(message)"
        case .timeout:
            return "请求超时，请检查网络后重试"
        case .invalidVerificationCode:
            return "验证码错误，请重新输入"
        case .verificationCodeExpired:
            return "验证码已过期，请重新获取"
        case .sendCodeTooFrequently:
            return "发送太频繁，请稍后再试"
        case .invalidPhoneNumber:
            return "手机号格式不正确"
        case .phoneNotRegistered:
            return "该手机号未注册"
        case .tokenExpired:
            return "登录已过期，请重新登录"
        case .tokenInvalid:
            return "登录状态异常，请重新登录"
        case .serverError(let code):
            return "服务器错误（\(code)），请稍后重试"
        case .unknown(let message):
            return "未知错误：\(message)"
        }
    }
}
}
