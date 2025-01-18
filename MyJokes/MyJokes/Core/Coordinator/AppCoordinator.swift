
//
//  AppCoordinator.swift
//  MyJokes
//
//  Created by Etush Maya on 16/01/2025.
//

import SwiftUI
import Combine

class AppCoordinator : AppCoordinatorProtocol {
    
    @Published var path: NavigationPath = NavigationPath()
    
    private var jokesService:JokesService
    
    init(jokesService: JokesService) {
        self.jokesService = jokesService
    }
    
    // MARK: - build views
    @MainActor @ViewBuilder
    func build(_ screen: AppScreen) -> some View {
        switch screen{
        case .details(let category):
            DetailsView(viewModel: DetailsViewModel(jokesService: jokesService, jokeCategory: category))
                .navigationTitle(category.rawValue)
        case .main:
            MainView(viewModel:MainViewModel(jokesService: jokesService))
        }
    }
    
    // MARK: - push/pop
    func push(_ screen: AppScreen) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
}
