//
//  CoreDataManager.swift
//  CatAlert
//
//  Created by ken on 2025/11/28.
//

import Foundation
import CoreData

class CoreDataManager {
    // MARK: - Init
    static let shared = CoreDataManager()
    private init() {
        persistentContainer = NSPersistentContainer(name: "ChatModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("unable to load core data stack: \(error)")
            }
        }
        viewContext = persistentContainer.viewContext
        
        viewContext.automaticallyMergesChangesFromParent = true
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    // MARK: - Properties
    private let persistentContainer: NSPersistentContainer
    private let viewContext: NSManagedObjectContext
    
    
    // MARK: - Helper
    private func convertToEntity(_ chatMessage: ChatMessage) -> Message {
        let entity = Message(context: viewContext)
        entity.id = chatMessage.id
        entity.content = chatMessage.content
        entity.role = chatMessage.role == .assistant ? "assistant" : "user"
        entity.timestamp = chatMessage.timestamp
        return entity
    }
    
    
    private func convertToStruct(_ message: Message) -> ChatMessage? {
        guard let id = message.id,
              let content = message.content,
              let roleString = message.role,
              let timeStamp = message.timestamp else {
            return nil
        }
        
        let role: ChatMessage.MessageRole = roleString == "assistant" ? .assistant : .user
        return ChatMessage(id: id, content: content, role: role, timestamp: timeStamp)
    }
    
    // MARK: - CRUD
    func saveMessage(_ chatMessage: ChatMessage) throws {
        let entity = convertToEntity(chatMessage)
        
        do {
            try viewContext.save()
        } catch {
            
        }
    }
    
    func fetchMessages() throws -> [ChatMessage] {
        let fetchRequest: NSFetchRequest<Message> = Message.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        
        do {
            let entities = try viewContext.fetch(fetchRequest)
            return entities.compactMap {
                convertToStruct($0)
            }
        } catch {
            
        }
    }
    
    
    
}
