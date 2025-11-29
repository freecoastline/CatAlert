//
//  CoreDataManager.swift
//  CatAlert
//
//  Created by ken on 2025/11/28.
//

import Foundation
import CoreData

enum CoreDataError: Error {
    case saveFailed(Error)
    case fetchFailed(Error)
    case deleteFailed(Error)
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .saveFailed(let error):
            return "Failed to save message: \(error.localizedDescription)"
        case .fetchFailed(let error):
            return "Failed to fetch messages: \(error.localizedDescription)"
        case .deleteFailed(let error):
            return "Failed to delete message: \(error.localizedDescription)"
        case .invalidData:
            return "Invalid message data"
        }
    }
}

class CoreDataManager {
    // MARK: - Init
    static let shared = CoreDataManager()
    private init() {
        persistentContainer = NSPersistentContainer(name: "ChatModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("unable to load core data stack: \(error)")
            }
            #if DEBUG
            print("✅ Core Data loaded successfully: \(description)")
            #endif
        }
        viewContext = persistentContainer.viewContext
        
        viewContext.automaticallyMergesChangesFromParent = true
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    // MARK: - Properties
    private let persistentContainer: NSPersistentContainer
    private let viewContext: NSManagedObjectContext
    private enum MessageRoleString {
        static let user = "user"
        static let assistant = "assistant"
    }
    
    // MARK: - Helper
    private func convertToEntity(_ chatMessage: ChatMessage) -> Message {
        let entity = Message(context: viewContext)
        entity.id = chatMessage.id
        entity.content = chatMessage.content
        entity.role = chatMessage.role == .assistant ? MessageRoleString.assistant : MessageRoleString.user
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
        
        let role: ChatMessage.MessageRole = roleString == MessageRoleString.assistant ? .assistant : .user
        return ChatMessage(id: id, content: content, role: role, timestamp: timeStamp)
    }
    
    // MARK: - CRUD
    func saveMessage(_ chatMessage: ChatMessage) throws {
        let entity = convertToEntity(chatMessage)
        
        do {
            try viewContext.save()
        } catch {
            throw CoreDataError.saveFailed(error)
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
            throw CoreDataError.fetchFailed(error)
        }
    }
    
    
    func deleteMessage(_ id: UUID) throws {
        let fetchRequest: NSFetchRequest<Message> = Message.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            results.forEach {
                viewContext.delete($0)
            }
            try viewContext.save()
        } catch {
            throw CoreDataError.deleteFailed(error)
        }
    }
    
    
}
