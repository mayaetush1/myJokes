//
//  APIJoke.swift
//  MyJokes
//
//  Created by Etush Maya on 16/01/2025.
//

struct APIJoke: Codable {
    let id : Int
    let lang : String
    let error : Bool
    let category: JokeCategory
    let type:JokeType
    let flags: JokeFlags
    let isSafe : Bool
    let joke : String?
    let setup: String?
    let delivery: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case lang
        case error
        case category
        case type
        case flags
        case isSafe  = "safe"
        case joke
        case setup
        case delivery
        }
    
}

struct JokeFlags:Codable{
    let isNsfw : Bool
    let isReligious : Bool
    let isPolitical : Bool
    let isRacist : Bool
    let isSexist : Bool
    let isExplicit : Bool
    
    enum CodingKeys: String, CodingKey {
        case isNsfw  = "nsfw"
        case isReligious = "religious"
        case isPolitical = "political"
        case isRacist = "racist"
        case isSexist  = "sexist"
        case isExplicit = "explicit"
           
        }
}



enum JokeCategory:String,CaseIterable, Codable{
    case misc =  "Misc"
    case programming = "Programming"
    case dark = "Dark"
    case pun = "Pun"
    case spooky = "Spooky"
    case christmas = "Christmas"
}

enum JokeType:String,Codable{
    case twoPart = "twopart"
    case single = "single"
}


