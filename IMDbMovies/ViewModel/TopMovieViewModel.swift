//
//  TopMovieViewModel.swift
//  IMDbMovies
//
//  Created by 沈清昊 on 5/9/23.
//

import Foundation
import Combine

class TopMovieViewModel: ObservableObject{
    let id: String
    
    var searchTopMovieString = "https://imdb-top-100-movies.p.rapidapi.com/"
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "imdb-top-100-movies.p.rapidapi.com"
    ]
    
    @Published var moive : MovieInfo?
    @Published var hasError = false
    @Published var error: LoadError?

    private var bag: Set<AnyCancellable> = []
    
    init(id: String){
        self.id = id
    }
    
    func fetchMovie(){
        searchTopMovieString += id
        
        guard let url = URL(string: searchTopMovieString) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> MovieInfo in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                let decoder = JSONDecoder()
                guard let movie = try? decoder.decode(MovieInfo.self, from: result.data) else{
                    throw LoadError.failedToDecode
                }
                return movie
            }
            .sink { [weak self] result in
                switch result{
                case .finished:
                    break
                case .failure(let error):
                    self?.hasError = true
                    self?.error = .custom(error: error)
                }
            } receiveValue: { [weak self] movie in
                self?.moive = movie
            }
            .store(in: &bag)
    }
}

extension TopMovieViewModel{
    enum LoadError: LocalizedError{
        case custom(error: Error)
        case failedToDecode
        case invalidStatusCode
        case failedToUnwrapOptional
        
        var errorDescription: String?{
            switch self {
            case .custom(let error):
                return error.localizedDescription
            case .failedToDecode:
                return "Failed to decode the data."
            case .invalidStatusCode:
                return "The GET Request failed due to the invalid status code."
            case .failedToUnwrapOptional:
                return "Unable to unwrap the optional value."
            }
        }
    }
}
