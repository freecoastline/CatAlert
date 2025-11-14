//
//  AuthManager.swift
//  CatAlert
//
//  Created by ken on 2025/11/13.
//

import Foundation

class AuthManager {
    // MARK: - Singleton
    static let shared = AuthManager()
    private init() {}
        
    // MARK: - Property
    private let tokenManager = TokenManager.shared
    private let networkService = NetworkService.shared
    
    private(set) var currentUser: User?
    
    // MARK: - Public Methods
    func sendVerificationCode(phone: String) async throws {
        guard phone.count == 11, phone.hasPrefix("1") else {
            throw AuthError.invalidPhoneNumber
        }
        
        let body = ["phone": phone]
        let response:SendCodeResponse = try await networkService.request(url: "auth/send-code", method: .post, body: body, requiresAuth: false)
        
        guard response.success else {
            throw AuthError.unknown(response.message ?? "发送验证码失败")
        }
    }
    
    func login(phone: String, code: String) async throws {
        guard phone.count == 11, phone.hasPrefix("1") else {
            throw AuthError.invalidPhoneNumber
        }
        
        guard code.count == 6, code.allSatisfy({ $0.isNumber }) else {
            throw AuthError.invalidVerificationCode
        }
        
        
        let body = ["phone": phone, "code": code]
        let loginResponse: LoginResponse = try await networkService.request(url: "/auth/login", method: .post, body: body, requiresAuth: false)
        
        try tokenManager.saveToken(loginResponse.token)
        currentUser = loginResponse.user
    }
    
    func logout() {
        tokenManager.deleteToken()
        currentUser = nil
    }
    
    var isLoggedIn: Bool {
        //TODO: 这里在内存中无currentUser且token有效时也是true，后续需要新增currentUser的懒加载
        tokenManager.isTokenValid()
    }
    
    func getCurrentUser() async throws -> User  {
        if let user = currentUser {
            return user
        }
        
        guard tokenManager.isTokenValid() else {
            throw AuthError.tokenInvalid
        }
        
        let user:User = try await networkService.request(url: "/user", method: .get, requiresAuth: true)
        currentUser = user
        return user
    }
}

