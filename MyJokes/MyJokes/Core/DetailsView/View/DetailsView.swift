//
//  DetailsView.swift
//  MyJokes
//
//  Created by Etush Maya on 17/01/2025.
//

import SwiftUI

struct DetailsView: View {
    @ObservedObject var viewModel:DetailsViewModel
    var body: some View {
        ScrollViewReader { proxy in
            VStack{
                List {
                    ForEach(viewModel.jokesSection) { section in
                        Section(header: Text(section.name).id(section.id)) {
                            ForEach(section.items) { joke in
                                JokeView(joke: joke)
                            }
                        }
                    }
                }
                
            }
            .listStyle(.grouped)
            Button(action: {
                withAnimation {
                    proxy.scrollTo(0, anchor: .bottom)
                }
            }) {
                Text("Back to Top")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

#Preview {
    var config = APIConfiguration()
    let webservice = WebService(baseURL: config.environment.baseURL)
    let jokesService = JokesService(apiService: webservice,
                                    storageService: CoreDataStorageManager())
    DetailsView(viewModel:DetailsViewModel(jokesService: jokesService, jokeCategory: .christmas))
}
