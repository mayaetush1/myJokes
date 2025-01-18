//
//  AppJoke.swift
//  MyJokes
//
//  Created by Etush Maya on 17/01/2025.
//


struct  AppJoke : Identifiable {
    let id : Int
    let category: JokeCategory
    let type:JokeType
    let flags: JokeFlags
    let isSafe : Bool
    let joke : String?
    let setup: String?
    let delivery: String?
    let isFavorite : Bool
    
    
    init(id: Int, category: JokeCategory,
         type: JokeType,
         flags: JokeFlags,
         isSafe: Bool,
         joke: String?,
         setup: String?,
         delivery: String?,
         isFavorite: Bool) {
        self.id = id
        self.category = category
        self.type = type
        self.flags = flags
        self.isSafe = isSafe
        self.joke = joke
        self.setup = setup
        self.delivery = delivery
        self.isFavorite = isFavorite
    }
    init(from apiJoke:APIJoke){
        self.init(id:apiJoke.id ,
                  category: apiJoke.category,
                  type: apiJoke.type,
                  flags: apiJoke.flags,
                  isSafe: apiJoke.isSafe,
                  joke: apiJoke.joke,
                  setup: apiJoke.setup,
                  delivery: apiJoke.delivery,
                  isFavorite: false)
    }
}
enum JokeFilters: String{
    case
}

