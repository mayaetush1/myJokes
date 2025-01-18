//
//  DBJoke+CoreDataProperties.swift
//  MyJokes
//
//  Created by Etush Maya on 18/01/2025.
//
//

import Foundation
import CoreData


extension DBJoke {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBJoke> {
        return NSFetchRequest<DBJoke>(entityName: "DBJoke")
    }

    @NSManaged public var id: Int64
    @NSManaged public var category: String?
    @NSManaged public var type: String?
    @NSManaged public var isSafe: Bool
    @NSManaged public var joke: String?
    @NSManaged public var setup: String?
    @NSManaged public var delivery: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var flags: DBJokeFlags?

}

extension DBJoke : Identifiable {

}
