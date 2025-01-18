//
//  CategoryCountView.swift
//  MyJokes
//
//  Created by Etush Maya on 16/01/2025.
//

import SwiftUI

struct CategoryCountView: View {
    
    let count :Int
    let jokeCategory :JokeCategory
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.teal)
                .opacity(0.3)
                .shadow(radius: 1)
            HStack{
                Text(jokeCategory.rawValue)
                    .font(.title)
                Text(": \(count)")
                    .font(.title)
                
            }
        }.padding(.horizontal)
    }
}

#Preview {
    CategoryCountView(count: 1, jokeCategory: .dark)
}
