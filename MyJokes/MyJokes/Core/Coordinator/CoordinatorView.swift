//
//  CoordinatorView.swift
//  MyJokes
//
//  Created by Etush Maya on 16/01/2025.
//


import SwiftUI

struct CoordinatorView: View {
    
    @StateObject var appCoordinator: AppCoordinator
    
    init() {
        var config = APIConfiguration()
        let webservice = WebService(baseURL: config.environment.baseURL)
        let jokesService = JokesService(apiService: webservice)
        let appCoordinator = AppCoordinator(jokesService: jokesService)
        _appCoordinator = StateObject(wrappedValue:appCoordinator)
    }
    
    var body: some View {
        NavigationStack(path:$appCoordinator.path) {
            ZStack{
                appCoordinator.build(AppScreen.main)
                
            }
            .navigationDestination(for: AppScreen.self) { screen in
                appCoordinator.build(screen)
            }
        }
        .environmentObject(appCoordinator)
    }
    
}



