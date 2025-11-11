//
//  User.swift
//  CatAlert
//
//  Created by ken on 2025/11/10.
//

import Foundation

struct User: Codable {
    let id: String
    let phone: String
    let nickname: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case phone = "phone"
        case nickname = "nick_name"
    }
}
