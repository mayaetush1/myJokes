//
//  MainViewModel.swift
//  MyJokes
//
//  Created by Etush Maya on 16/01/2025.
//

import SwiftUI
import Combine

class MainViewModel:ObservableObject{
    
    @Published var jokeDict =  [JokeCategory:[AppJoke]]()
    private var cancellables = Set<AnyCancellable>()
    
    private var jokesService:JokesService
    
    init(jokesService: JokesService) {
        self.jokesService = jokesService
        jokesService.$jokesDict
            .receive(on: DispatchQueue.main)
            .sink { [weak self] jokeDict in
                self?.jokeDict = jokeDict
            }
            .store(in: &cancellables)
    }
    func addJoke(){
        jokesService.addJoke()
    }
    
}
