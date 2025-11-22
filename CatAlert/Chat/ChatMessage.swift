//
//  ChatMessage.swift
//  CatAlert
//
//  Created by ken on 2025/11/22.
//

import Foundation
struct ChatMessage {
    let id: UUID
    let content: String
    let role: MessageRole
    let timestamp: Date
    
    enum MessageRole {
        case user
        case assistant
    }
}
