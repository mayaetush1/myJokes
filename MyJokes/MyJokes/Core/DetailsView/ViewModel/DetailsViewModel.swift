//
//  DetailsViewModel.swift
//  MyJokes
//
//  Created by Etush Maya on 17/01/2025.
//

import Foundation
import Combine


class  DetailsViewModel : ObservableObject {
    
    @Published var sections =  [DetailsViewListSections]()
    @Published var selectedFilter: String = "All"
    @Published var jokeCategory :JokeCategory
    private var jokesService:JokesService
    private var cancellables: Set<AnyCancellable> = []
    @Published private(set) var filteredSections: [DetailsViewListSections] = []
    
    var isEmpty: Bool {
           filteredSections.allSatisfy { $0.items.isEmpty }
       }
    
    init(jokesService: JokesService,
         jokeCategory:JokeCategory) {
        self.jokesService = jokesService
        self.jokeCategory = jokeCategory
        self.setupSections()
        self.setupBindings()
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
        sections = sectionsArray
    }
    
    
    private func setupBindings() {
        $selectedFilter
            .combineLatest($sections)
            .map { selectedCategory, sections in
                self.filterSections(sections, by: selectedCategory)
            }
            .assign(to: &$filteredSections)
    }
    
    private func filterSections(_ sections: [DetailsViewListSections], by filter: String) -> [DetailsViewListSections] {
        guard filter != "All" else { return sections }
        
        return sections.map { section in
            let filteredItems = section.items.filter { joke in
                if filter == "nsfw" {return joke.flags.isNsfw == true}
                if filter == "religious" {return joke.flags.isReligious == true}
                if filter == "political" {return joke.flags.isPolitical == true}
                if filter == "racist" {return joke.flags.isRacist == true}
                if filter == "sexist" {return joke.flags.isSexist == true}
                if filter == "explicit" {return joke.flags.isExplicit == true}
                return false
            }
            return DetailsViewListSections(id: section.id, name: section.name, items: filteredItems)
        }.filter { !$0.items.isEmpty }
    }
}
