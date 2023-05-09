//
//  ContentView.swift
//  IMDbMovies
//
//  Created by 沈清昊 on 5/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink("Top 100 movies list") {
                    HundredMoviesView()
                }
                .tint(.yellow)
                .background(Color.black)
                .cornerRadius(10)
                .padding()
            }
            .navigationTitle("Welcome to use IMDb")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
