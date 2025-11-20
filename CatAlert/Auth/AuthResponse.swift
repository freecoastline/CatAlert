//
//  AuthResponse.swift
//  CatAlert
//
//  Created by ken on 2025/11/13.
//

import Foundation

struct SendCodeResponse: Codable {
    let success: Bool
    let message: String?
}

struct LoginResponse: Codable {
    let token: AuthToken
    let user: User
}

struct RegisterResponse: Codable {
    let message: String
    let user: User
}
