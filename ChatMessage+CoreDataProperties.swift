//
//  ChatMessage+CoreDataProperties.swift
//  CatAlert
//
//  Created by ken on 2025/11/28.
//
//

public import Foundation
public import CoreData


public typealias ChatMessageCoreDataPropertiesSet = NSSet

extension ChatMessage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatMessage> {
        return NSFetchRequest<ChatMessage>(entityName: "ChatMessage")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var content: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var role: String?

}

extension ChatMessage : Identifiable {

}
