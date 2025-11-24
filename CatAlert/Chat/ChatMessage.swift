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
    
    init(id: UUID, content: String, role: MessageRole, timestamp: Date) {
        self.id = id
        self.content = content
        self.role = role
        self.timestamp = timestamp
    }
    
    init(content: String, role: MessageRole) {
        self.init(id: UUID(), content: content, role: role, timestamp: Date())
    }
}
