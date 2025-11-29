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
    
    
    
    
}
