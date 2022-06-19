//
//  MoviesData.swift
//  Filmes Teste
//
//  Created by Francisco Neto on 16/06/22.
//

import Foundation
struct MoviesData: Decodable {
    let items: [Movies]
}
struct Movies: Decodable {
    let id: String
    let rank: String
    let rankUpDown: String
    let fullTitle: String
    let year: String
    let image: String
    let crew: String
    let imDbRating: String
}


