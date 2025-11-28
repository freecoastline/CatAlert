//
//  Message+CoreDataProperties.swift
//  CatAlert
//
//  Created by ken on 2025/11/28.
//
//

public import Foundation
public import CoreData


public typealias MessageCoreDataPropertiesSet = NSSet

extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var content: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var role: String?

}

extension Message : Identifiable {

}
