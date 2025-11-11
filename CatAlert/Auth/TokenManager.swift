//
//  TokenManager.swift
//  CatAlert
//
//  Created by ken on 2025/11/11.
//

import Foundation
import Security

class TokenManager {
    // MARK: - Init
    static let shared = TokenManager()
    private init() {}
    
    // MARK: - Public Methods
    func saveToken(_ token: AuthToken) throws {
        
    }
    
    func loadToken() -> AuthToken? {
        
    }
    
    func deleteToken() {
        
    }
    
    func isTokenValid() -> Bool {
        
    }
}
