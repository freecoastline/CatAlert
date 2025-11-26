//
//  OpenAIModels.swift
//  CatAlert
//
//  Created by ken on 2025/11/26.
//

import Foundation

struct OpenAIRequest: Codable {
    let model: String
    let messages: [OpenAIMessage]
}

struct OpenAIMessage: Codable {
    let role: String
    let content: String
}

struct OpenAIResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: OpenAIMessage
}
