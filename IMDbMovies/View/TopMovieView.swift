//
//  TopMovieView.swift
//  IMDbMovies
//
//  Created by 沈清昊 on 5/9/23.
//

import SwiftUI

struct TopMovieView: View {
    @StateObject var vm: TopMovieViewModel
    
    var body: some View {
        VStack{
            if let movie = vm.moive{
                Text(movie.title ?? "")
                    .font(.title)
                Text("\(movie.rank ?? 0)")
                    .font(.title2)
                HStack{
                    Image(systemName: "star.fill")
                    Text(movie.rating ?? "")
                }
                Text("Year: \(movie.year ?? 0)")
                if let genres = movie.genre{
                    Section {
                        List{
                            ForEach(genres, id: \.self){ genre in
                                Text(genre)
                            }
                        }
                        .listStyle(.plain)
                    } header: {
                        Text("Genre:")
                    }
                }
                
                if let directors = movie.director{
                    Section {
                        List{
                            ForEach(directors, id: \.self) { director in
                                Text(director)
                            }
                        }
                        .listStyle(.plain)
                    } header: {
                        Text("Director: ")
                    }
                }
                
                if let writers = movie.writers{
                    Section {
                        List{
                            ForEach(writers, id: \.self) { writer in
                                Text(writer)
                            }
                        }
                        .listStyle(.plain)
                    } header: {
                        Text("Writers: ")
                    }
                }
                AsyncImage(url: URL(string: movie.image ?? ""))
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchMovie)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct TopMovieView_Previews: PreviewProvider {
    static var previews: some View {
        TopMovieView(vm: TopMovieViewModel(id: ""))
    }
}
