//
//  Entity+CoreDataProperties.swift
//  To Do App
//
//  Created by LinhMAC on 25/01/2024.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var title: String?
    @NSManaged public var desciption: String?

}

extension Entity : Identifiable {

}
