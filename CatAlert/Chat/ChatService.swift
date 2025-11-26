//
//  ChatService.swift
//  CatAlert
//
//  Created by ken on 2025/11/26.
//

import Foundation
class ChatService {
    // MARK: - Singleton
    static let shared = ChatService()
    private init() {}
    
    // MARK: - Properties
    private let apiKey = "YOUR_API_KEY_HERE"  // We'll add this later
    private let baseURL = "https://api.openai.com/v1/chat/completions"
    
    
    
}
