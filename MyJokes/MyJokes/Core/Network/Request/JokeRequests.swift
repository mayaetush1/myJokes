//
//  JokeRequests.swift
//  MyJokes
//
//  Created by Etush Maya on 16/01/2025.
//


import Foundation

enum JokeRequests : RequestProtocol {
 
case allJokes

    
    var path: String {
        
        switch self {
        case .allJokes:
                return "/joke/Any"
        }
     }

    var method: RequestMethod {
        switch self {
        case .allJokes:
            return .get
            
        }
    }

     var queryItems: [URLQueryItem]? {
         switch self {
         case .allJokes:
             let amount = URLQueryItem(name: "amount", value: "1")
             return [amount]
         }
     }

     var body: [String: Any]? {
         switch self {
         default:
             return nil
         }
     }

     var mockFile: String? {
         switch self {
         default:
             return nil
         }
     }
    
    
}
