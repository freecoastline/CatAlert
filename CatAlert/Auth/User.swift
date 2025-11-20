//
//  User.swift
//  CatAlert
//
//  Created by ken on 2025/11/10.
//

import Foundation

struct User: Codable {
    let id: String
    let phone: String?
    let username: String?
    let email: String?
    let role: String?
    let is_active: Bool?
    let created_at: Date?
//    id: str
//    username: str
//    email: str
//    role: str
//    is_active: bool
//    created_at: datetime
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case phone = "phone"
//        case username = "nick_name"
//    }
}
