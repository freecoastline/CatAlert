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
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String : KeychainKeys.service,
            kSecAttrAccount as String : KeychainKeys.account,
            kSecReturnData as String : true,
            kSecMatchLimit as String : kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess else {
            return nil
        }
        
        guard let tokenData = result as? Data else {
            return nil
        }
        let decoder = JSONDecoder()
        return try? decoder.decode(AuthToken.self, from: tokenData)
    }
    
    func deleteToken() {
        let query: [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrService as String : KeychainKeys.service,
            kSecAttrAccount as String : KeychainKeys.account
        ]
        let status = SecItemDelete(query as CFDictionary)
        if status == errSecSuccess {
            print("✅ Token 删除成功")
        } else if status == errSecItemNotFound {
            print("ℹ️ Token 本来就不存在")
        } else {
            print("⚠️ 删除 Token 时出现异常，状态码：\(status)")
        }
    }
    
    func isTokenValid() -> Bool {
        guard let token = loadToken() else {
            return false
        }
        return !token.isExpired
    }
}
