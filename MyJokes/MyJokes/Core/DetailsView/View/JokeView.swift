//
//  JokeView.swift
//  MyJokes
//
//  Created by Etush Maya on 17/01/2025.
//

import SwiftUI

struct JokeView: View {
    var joke: AppJoke
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {}) {
                    
                    Image(systemName: joke.isFavorite ? "heart.fill" : "heart")
                    Text(joke.isFavorite ? "Liked" : "Like")
                }.padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    .padding()
            }
            Text(joke.type == .twoPart ? joke.setup ?? "": joke.joke ?? "" )
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .font(.subheadline)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20)
                    .stroke(.teal, lineWidth: 2))
            if joke.type == .twoPart {
                HStack{
                    Text(joke.delivery ?? "")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .font(.subheadline)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20)
                            .stroke(.teal, lineWidth: 2))
                }
            }
        }
    }
}

#Preview {
    JokeView(joke: AppJoke(id: 1,
                           category: .programming,
                           type: .twoPart,
                           flags: JokeFlags(isNsfw: true,
                                            isReligious: false,
                                            isPolitical: false,
                                            isRacist: false,
                                            isSexist: false,
                                            isExplicit: false),
                           isSafe: true,
                           joke: nil,
                           setup: "How do you know God is a shitty programmer?",
                           delivery: "He wrote the OS for an entire universe, but didn't leave a single useful comment",
                           isFavorite: true))
}
