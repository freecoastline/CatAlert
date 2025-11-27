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
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw ChatServiceError.serverError
        }
        
        let openAIResponse = try JSONDecoder().decode(OpenAIResponse.self, from: data)
        
        guard let aiMessage = openAIResponse.choices.first?.message.content else {
            throw ChatServiceError.serverError
        }
        
        return aiMessage
    }
    
    
    // MARK: - Mock for Testing
    func sendMessageMock(messages: [ChatMessage]) async throws -> String {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000)  // 1 second

        // Return mock response based on user's message
        let lastMessage = messages.last?.content ?? ""

        if lastMessage.lowercased().contains("cat") {
            return "Cats are wonderful pets! They're independent but affectionate. Is there something specific about your cat you'd like to know?"
        } else if lastMessage.lowercased().contains("sick") {
            return "I'm sorry to hear your pet isn't feeling well. Common symptoms to watch for include lethargy, loss of appetite, and vomiting. Have you noticed any of these?"
        } else {
            return "I'm here to help with your pet health questions! What would you like to know?"
        }
    }
}
