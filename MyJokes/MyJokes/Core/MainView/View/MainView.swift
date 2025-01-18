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
            ZStack{
                //Category views
                ScrollView{
                    LazyVStack{
                        ForEach(Array(viewModel.jokeDict.keys), id: \.self) { category in
                            if let value =  viewModel.jokeDict[category] {
                                CategoryCountView(count: value.count, jokeCategory:category)
                                    .frame(height: 80)
                                    .onTapGesture {
                                        appCoordinator.push(.details(category: category))
                                    }
                            }
                        }
                    }
                }.refreshable {
                    viewModel.addJoke()
                }
                // Button view
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            viewModel.addJoke()
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
                        }
                    }
                }.padding()
            }.navigationTitle("My jokes 😊")
        }
    }
}

#Preview {
    var config = APIConfiguration()
    let webservice = WebService(baseURL: config.environment.baseURL)
    let jokesService = JokesService(apiService: webservice,
                                    storageService: CoreDataStorageManager())
    MainView(viewModel: MainViewModel(jokesService: jokesService))
}
