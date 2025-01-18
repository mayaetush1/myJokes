//
//  MainView.swift
//  MyJokes
//
//  Created by Etush Maya on 16/01/2025.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject   private var  appCoordinator: AppCoordinator
    @ObservedObject var viewModel:MainViewModel
    var body: some View {
        NavigationView {
            VStack{
                ForEach(Array(viewModel.jokeDict.keys), id: \.self) { category in
                    if let value =  viewModel.jokeDict[category] {
                        CategoryCountView(count: value.count, jokeCategory:category)
                            .onTapGesture {
                                appCoordinator.push(.details(category: category))
                            }
                    }
                }
                Button(action: {
                    viewModel.addJoke()
                }) {
                    Text("+")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 30)
                        .background(Color.teal)
                        .cornerRadius(20)
                }
            }.navigationTitle("My jokes 😊")
        }
    }
}

#Preview {
    var config = APIConfiguration()
    let webservice = WebService(baseURL: config.environment.baseURL)
    let jokesService = JokesService(apiService: webservice)
    MainView(viewModel: MainViewModel(jokesService: jokesService))
}
