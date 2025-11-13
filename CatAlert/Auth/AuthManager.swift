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
    func sendAuthorizationCode(phoone: String) async throws {
        
    }
    
    func login(phone: String, code: String) async throws {
        
    }
    
    func logout() {
        
    }
    
    var isLoggedIn: Bool {
        
    }
}

