//
//  DBJokeFlags+CoreDataProperties.swift
//  MyJokes
//
//  Created by Etush Maya on 18/01/2025.
//
//

import Foundation
import CoreData


extension DBJokeFlags {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBJokeFlags> {
        return NSFetchRequest<DBJokeFlags>(entityName: "DBJokeFlags")
    }

    @NSManaged public var isNsfw: Bool
    @NSManaged public var isReligious: Bool
    @NSManaged public var isPolitical: Bool
    @NSManaged public var isRacist: Bool
    @NSManaged public var isSexist: Bool
    @NSManaged public var isExplicit: Bool
    @NSManaged public var joke: DBJoke?

}

extension DBJokeFlags : Identifiable {

}
