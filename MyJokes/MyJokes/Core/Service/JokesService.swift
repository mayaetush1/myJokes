//
//  JokesService.swift
//  MyJokes
//
//  Created by Etush Maya on 16/01/2025.
//

import Foundation

class JokesService:ObservableObject{
    
    
    @Published private(set) var  jokesDict : [JokeCategory:[APIJoke]] = {
        var dict =  [JokeCategory:[APIJoke]]()
        for category in JokeCategory.allCases {
            dict[category] = [APIJoke]()
        }
        return dict
    }()
    
    
    private let apiService : ApiClientProtocol
    
    init(apiService:ApiClientProtocol){
        self.apiService = apiService
    }

    
    func addJoke() {
        Task{
            do {
           let joke =  try await apiService.request(endpoint: JokeRequests.allJokes, responseModel: APIJoke.self)
           addJoke(joke)
            }catch{
                print("error")
            }
        }
    }
    func addJoke(_ joke:APIJoke){
        jokesDict[joke.category]?.append(joke)
    }
    
}
