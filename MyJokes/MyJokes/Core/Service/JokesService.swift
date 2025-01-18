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
    private let storageService : StorageManagerProtocol
    
    init(apiService:ApiClientProtocol,
         storageService:StorageManagerProtocol){
        self.apiService = apiService
        self.storageService = storageService
        getJokesFromStorage()
    }
    
    private func getJokesFromStorage(){
        let jokes = storageService.fetchJokes()
        let dbDict =  Dictionary(grouping:jokes , by:{ $0.category })
        for key in dbDict.keys{
            jokesDict[key]?.append(contentsOf:dbDict[key,default:[AppJoke]()])
        }
    }
    
    private func addJoke(_ joke: AppJoke){
        guard let arrayOfJokesByCategory = jokesDict[joke.category] else {return}
        // Dont save the same joke twice
        if arrayOfJokesByCategory.contains(where: { appJoke in
            appJoke.id == joke.id
        }) {
            print("The same joke from server")
            return}
        jokesDict[joke.category]?.append(joke)
        storageService.saveJoke(joke)
    }
    
    
    func getJokes(category:JokeCategory) -> [AppJoke]{
        guard let jokesArray =  jokesDict[category] else {return [AppJoke]()}
        return jokesArray
    }
    
    func addJoke() {
        Task{
            do {
                let joke =  try await apiService.request(endpoint: JokeRequests.allJokes, responseModel: APIJoke.self)
                print("joke from server")
                addJoke(AppJoke(from: joke))
                
            }catch (let error){
                print("!!!!! error from server \(error)")
            }
            
        }
    }
    
}
