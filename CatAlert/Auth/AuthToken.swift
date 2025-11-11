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
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case issueAt = "issue_at"
        case expiredIn = "expired_in"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
        self.issueAt = try container.decodeIfPresent(Date.self, forKey: .issueAt) ?? Date()
        self.expiredIn = try container.decode(TimeInterval.self, forKey: .expiredIn)
    }
    
    init(accessToken: String, refreshToken: String, expiredIn: TimeInterval) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.issueAt = Date()
        self.expiredIn = expiredIn
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = try encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accessToken, forKey: .accessToken)
        try container.encode(refreshToken, forKey: .refreshToken)
        try container.encode(issueAt, forKey: .issueAt)
        try container.encode(expiredIn, forKey: .expiredIn)
    }
}
