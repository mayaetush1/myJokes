//
//  DetailsViewModel.swift
//  MyJokes
//
//  Created by Etush Maya on 17/01/2025.
//

import Foundation
import Combine


class  DetailsViewModel : ObservableObject {
    
    var fullJokeArray : [DetailsViewListSections]
    @Published var jokesSection : [DetailsViewListSections]
    
    @Published var jokeCategory :JokeCategory
    
    private var jokesService:JokesService
    
    init(jokesService: JokesService,
         jokeCategory:JokeCategory) {
        
        self.jokesService = jokesService
        self.jokeCategory = jokeCategory
        
        let arrayOfJokes = jokesService.getJokes(category: jokeCategory)
        let dictByType =  Dictionary(grouping: arrayOfJokes, by: { $0.type })
        let arrayOfKeys = Array(dictByType.keys)
        var sectionsArray =  [DetailsViewListSections]()
        for (index,section) in arrayOfKeys.enumerated() {
            let items = dictByType[section,default: [AppJoke]()]
            sectionsArray.append(DetailsViewListSections(id: index, name: section.rawValue, items:items))
        }
        fullJokeArray = sectionsArray
        jokesSection = sectionsArray
    }
}
