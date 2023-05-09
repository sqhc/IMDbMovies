//
//  MovieDataModel.swift
//  IMDbMovies
//
//  Created by 沈清昊 on 5/9/23.
//

import Foundation

struct MovieInfo: Codable{
    let rank: Int?
    let title: String?
    let rating: String?
    let id: String?
    let year: Int?
    let image: String?
    let description: String?
    let genre: [String]?
    let director: [String]?
    let writers: [String]?
    let imdbid: String?
}
