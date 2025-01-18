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
            ZStack{
                VStack{
                    // Picker
                    Picker("Filter by Category", selection: $viewModel.selectedFilter) {
                        Text("All").tag("All")
                        Text("Nsfw").tag("nsfw")
                        Text("Religious").tag("religious")
                        Text("Political").tag("political")
                        Text("Racist").tag("racist")
                        Text("Sexist").tag("sexist")
                        Text("Explicit").tag("explicit")
                    }
                    //Empty view
                    if viewModel.isEmpty{
                        Text("No jokes available😢")
                            .font(.headline)
                            .foregroundColor(Color.blue)
                            .padding()
                        Spacer()
                    }else{
                        // list view
                        List {
                            ForEach(viewModel.filteredSections) { section in
                                Section(header: Text(section.name).id(section.id)) {
                                    ForEach(section.items) { joke in
                                        JokeView(joke: joke)
                                    }
                                }
                            }
                        }.listSectionSeparator(.hidden)
                      
                    }
                    
                }
                //Button view
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            withAnimation {
                                proxy.scrollTo(0, anchor: .bottom)
                            }
                        }) {
                            Text("Back to Top")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(30)
                        }
                        .background(Color.clear)
                        .padding()
                    }
                }
            }
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
