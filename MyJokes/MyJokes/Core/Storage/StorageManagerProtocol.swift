//
//  StorageManagerProtocol.swift
//  MyJokes
//
//  Created by Etush Maya on 18/01/2025.
//

import Foundation
import CoreData

protocol StorageManagerProtocol {
    
    func saveJoke(_ joke: AppJoke)
    func fetchJokes() -> [AppJoke]
}

class CoreDataStorageManager: StorageManagerProtocol {
    
    private let persistentContainer: NSPersistentContainer
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    init() {
        persistentContainer = NSPersistentContainer(name: "MyJokes")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func saveJoke(_ joke: AppJoke) {
        let dbJoke = DBJoke(context: context)
        dbJoke.id = Int64(joke.id)
        
        dbJoke.category = joke.category.rawValue
        dbJoke.type = joke.type.rawValue
        dbJoke.isSafe = joke.isSafe
        dbJoke.joke = joke.joke
        dbJoke.setup = joke.setup
        dbJoke.delivery = joke.delivery
        let dbFlags = DBJokeFlags(context: context)
        dbFlags.isNsfw = joke.flags.isNsfw
        dbFlags.isReligious = joke.flags.isReligious
        dbFlags.isPolitical = joke.flags.isPolitical
        dbFlags.isRacist = joke.flags.isRacist
        dbFlags.isSexist = joke.flags.isSexist
        dbFlags.isExplicit = joke.flags.isExplicit
        
        dbJoke.flags = dbFlags
        print("\(dbJoke)")
        
        saveContext()
    }
    
    func fetchJokes() -> [AppJoke] {
        let fetchRequest: NSFetchRequest<DBJoke> = DBJoke.fetchRequest()
        do {
            let dbJokes  = try context.fetch(fetchRequest)
            let appJokes : [AppJoke?]   = dbJokes.map{ dbJoke in
                if   let jokeCategory = JokeCategory(rawValue: dbJoke.category ?? ""),
                     let jokeType = JokeType(rawValue: dbJoke.type ?? "") {
                    return AppJoke(id: Int(dbJoke.id),
                            category: jokeCategory,
                            type: jokeType,
                            flags: JokeFlags(
                                isNsfw: dbJoke.flags?.isNsfw ?? false,
                                isReligious: dbJoke.flags?.isReligious ?? false,
                                isPolitical: dbJoke.flags?.isPolitical ?? false,
                                isRacist: dbJoke.flags?.isRacist ?? false,
                                isSexist: dbJoke.flags?.isSexist ?? false,
                                isExplicit: dbJoke.flags?.isExplicit ?? false
                            ),
                            isSafe: dbJoke.isSafe,
                            joke: dbJoke.joke,
                            setup: dbJoke.setup,
                            delivery: dbJoke.delivery)
                }
                return nil
            }
            return appJokes.compactMap { $0 }
        } catch {
            print("Failed to fetch jokes: \(error)")
            return []
        }
    }
    
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
