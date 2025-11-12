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
    
    // MARK: - Constants
    private enum KeychainKeys {
        static let service = "com.catal.service"
        static let account = "authToken"
    }
    
    // MARK: - Public Methods
    func saveToken(_ token: AuthToken) throws {
        let encoder = JSONEncoder()
        let tokenData = try encoder.encode(token)
        let query: [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrService as String : KeychainKeys.service,
            kSecAttrAccount as String : KeychainKeys.account,
            kSecValueData as String : tokenData
        ]
        
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw AuthError.unknown("保存Token失败,状态码 \(status)")
        }
    }
    
    func loadToken() -> AuthToken? {
        
    }
    
    func deleteToken() {
        
    }
    
    func isTokenValid() -> Bool {
        
    }
}
