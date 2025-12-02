//
//  NetworkService.swift
//  CatAlert
//
//  Created by ken on 2025/11/12.
//

import Foundation
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

class NetworkService {
    // MARK: - Singleton
    static let shared = NetworkService()
    private init() {}
    
    // MARK: - Properties
    private let session = URLSession.shared
    private let baseURL = "http://192.168.31.235:8000"
    
    // MARK: - Public Method
    func request<T: Codable>(
        url: String,
        method: HTTPMethod,
        body: Encodable? = nil,
        requiresAuth: Bool = false
    ) async throws -> T  {
        let fullURL = baseURL + url
        guard let url = URL(string: fullURL) else {
            throw AuthError.networkError("无效url")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if requiresAuth {
            guard let token = TokenManager.shared.loadToken() else {
                throw AuthError.tokenInvalid
            }
            
            request.setValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            let encoder = JSONEncoder()
            let bodyData: Data = try encoder.encode(body)
            request.httpBody = bodyData

            // Debug: Print request body
            if let jsonString = String(data: bodyData, encoding: .utf8) {
                print("📤 Request to: \(fullURL)")
                print("📤 Method: \(method.rawValue)")
                print("📤 Body: \(jsonString)")
            }
        } else {
            print("📤 Request to: \(fullURL)")
            print("📤 Method: \(method.rawValue)")
            print("📤 Body: none")
        }

        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AuthError.networkError("无效的响应，可能并非HTTP协议")
        }
        
        // Debug: Print response
        print("📥 Response status: \(httpResponse.statusCode)")
        if let responseString = String(data: data, encoding: .utf8) {
            print("📥 Response body: \(responseString)")
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw AuthError.serverError(httpResponse.statusCode)
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let result = try decoder.decode(T.self, from: data)
            print("✅ Decoding success!")
            return result
        } catch let DecodingError.keyNotFound(key, context) {
            print("❌ 缺少字段: \(key.stringValue)")
            print("❌ 路径: \(context.codingPath)")
            print("❌ 说明: \(context.debugDescription)")
        } catch let DecodingError.typeMismatch(type, context) {
            print("❌ 类型不匹配: 期望 \(type)")
            print("❌ 路径: \(context.codingPath)")
            print("❌ 说明: \(context.debugDescription)")
        } catch let DecodingError.dataCorrupted(context) {
            print("❌ 数据损坏")
            print("❌ 路径: \(context.codingPath)")
            print("❌ 说明: \(context.debugDescription)")

        } catch {
            print("❌ 未知解码错误: \(error)")
        }
        return RegisterResponse(message: "none", user: User(id: "1", phone: "111", username: "11", email: "1", role: "11", is_active: false, created_at: Date())) as! T
    }
    
    
}
