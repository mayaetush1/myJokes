//
//  DetailsViewModel.swift
//  MyJokes
//
//  Created by Etush Maya on 17/01/2025.
//

import Foundation
import Combine


class  DetailsViewModel : ObservableObject {
    
    @Published var jokesSection =  [DetailsViewListSections]()
    
    @Published var jokeCategory :JokeCategory
    
    private var jokesService:JokesService
    
    init(jokesService: JokesService,
         jokeCategory:JokeCategory) {
        
        self.jokesService = jokesService
        self.jokeCategory = jokeCategory
        self.setupSections()
    }
    
    private func setupSections(){
        // setup sections
        let arrayOfJokes = jokesService.getJokes(category: jokeCategory)
        var sectionsArray =  [DetailsViewListSections]()
        let singleJokes = DetailsViewListSections(id: 0 ,
                                                  name:"Single Jokes",
                                                  items:arrayOfJokes.filter({ $0.type == .single}))
        let twoPartsJokes = DetailsViewListSections(id: 1 ,
                                               name:"Two Part Jokes",
                                               items:arrayOfJokes.filter({ $0.type == .twoPart}))
        sectionsArray.append(singleJokes)
        sectionsArray.append(twoPartsJokes)
        jokesSection = sectionsArray
    }
    
   
}
