//
//  AuthToken.swift
//  CatAlert
//
//  Created by ken on 2025/11/11.
//

import Foundation

struct AuthToken: Codable {
    let accessToken: String
    let refreshToken: String
    let issueAt: Date
    let expiredIn: TimeInterval
    
    var isExpired: Bool {
        let now = Date()
        if now.timeIntervalSince(issueAt) > expiredIn {
            return true
        }
        return false
    }
    
    init(accessToken: String, refreshToken: String, expiredIn: TimeInterval) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.issueAt = Date()
        self.expiredIn = expiredIn
    }
}
