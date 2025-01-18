//
//  JokesService.swift
//  MyJokes
//
//  Created by Etush Maya on 16/01/2025.
//

import Foundation

class JokesService:ObservableObject{
    
    
    @Published private(set) var  jokesDict : [JokeCategory:[AppJoke]] = {
        var dict =  [JokeCategory:[AppJoke]]()
        for category in JokeCategory.allCases {
            dict[category] = [AppJoke]()
        }
        return dict
    }()
    
    
    private let apiService : ApiClientProtocol
    
    init(apiService:ApiClientProtocol){
        self.apiService = apiService
    }
    
    func getJokes(category:JokeCategory) -> [AppJoke]{
        guard let jokesArray =  jokesDict[category] else {return [AppJoke]()}
        return jokesArray
    }
    func addJoke() {
        Task{
            do {
                let joke =  try await apiService.request(endpoint: JokeRequests.allJokes, responseModel: APIJoke.self)
                addJoke(AppJoke(from: joke))
            }catch{
                print("error")
            }
        }
        
    }
    
    private func addJoke(_ joke: AppJoke){
        jokesDict[joke.category]?.append(joke)
    }
    
}
