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
        
    }
    
    func login(phone: String, code: String) async throws {
        
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

