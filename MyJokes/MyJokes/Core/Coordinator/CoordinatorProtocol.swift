
//
//  CoordinatorProtocol.swift
//  MyJokes
//
//  Created by Etush Maya on 16/01/2025.
//

import SwiftUI

// MARK : - Screen

protocol Screen: Identifiable, Hashable {
    var id: Self { get}
}



enum AppScreen:Screen{
    case main
    case details(category:JokeCategory)
    var id: Self { return self}
}





protocol AppCoordinatorProtocol: ObservableObject {
    
    var path: NavigationPath { get set }

}


