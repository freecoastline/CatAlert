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
}

class NetworkService {
    // MARK: - Singleton
    static let shared = NetworkService()
    private init() {}
    
    // MARK: - Properties
    private let session = URLSession.shared
    private let baseURL = "https://api.example.com"
    
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
        }
    
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AuthError.networkError("无效的响应，可能并非HTTP协议")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw AuthError.networkError("401")
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: data)
        return result
    }
    
    
}
