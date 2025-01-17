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
        VStack{
            ForEach(Array(viewModel.jokeDict.keys), id: \.self) { key in
                if let value =  viewModel.jokeDict[key] {
                    CategoryCountView(count: value.count, jokeCategory:key)
                        .onTapGesture {
                           
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
        }
    }
}

#Preview {
    var config = APIConfiguration()
    let webservice = WebService(baseURL: config.environment.baseURL)
    let jokesService = JokesService(apiService: webservice)
    MainView(viewModel: MainViewModel(jokesService: jokesService))
}
