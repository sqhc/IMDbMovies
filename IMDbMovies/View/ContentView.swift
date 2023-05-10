//
//  ContentView.swift
//  IMDbMovies
//
//  Created by 沈清昊 on 5/9/23.
//

import SwiftUI

struct ContentView: View {
    @State var selecteion = "1"
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
                Divider()
                Text("Pick a top movie by yourself")
                    .font(.title2)
                Picker(selection: $selecteion) {
                    ForEach(1...100, id: \.self) { id in
                        Text("Top \(id)")
                            .tag("\(id)")
                    }
                } label: {
                    Text("Top ")
                }
                .pickerStyle(WheelPickerStyle())
                NavigationLink("Search") {
                    TopMovieView(vm: TopMovieViewModel(id: "top\(selecteion)"))
                }
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
