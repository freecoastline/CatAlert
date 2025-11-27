//
//  ChatService.swift
//  CatAlert
//
//  Created by ken on 2025/11/26.
//

import Foundation

enum ChatServiceError: Error {
    case invalidURL
    case serverError
    case noResponse
}

class ChatService {
    // MARK: - Singleton
    static let shared = ChatService()
    private init() {}
    
    // MARK: - Properties
    private let apiKey = "YOUR_API_KEY_HERE"
    private let baseURL = "https://api.openai.com/v1/chat/completions"
    
    // MARK: - Public methods
    func sendMessage(_ messages: [ChatMessage]) async throws -> String {
        let openAIMessages = messages.map { chatMessage in
            OpenAIMessage(role: chatMessage.role == .assistant ? "assistant" : "user", content: chatMessage.content)
        }
        
        let OpenAIRequest = OpenAIRequest(model: "gpt-3.5-turbo", messages: openAIMessages)
        let jsonData = try JSONEncoder().encode(OpenAIRequest)
        
        guard let url = URL(string: baseURL) else {
            throw ChatServiceError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bear \(apiKey)", forHTTPHeaderField: "Authentication")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpRespnse = response as? HTTPURLResponse,
              (200...299).contains(httpRespnse.statusCode) else {
            throw ChatServiceError.serverError
        }
        
        let openAIResponse = try JSONDecoder().decode(OpenAIResponse.self, from: data)
        
        guard let aiMessage = openAIResponse.choices.first?.message.content else {
            throw ChatServiceError.serverError
        }
        
        return aiMessage
    }
}
