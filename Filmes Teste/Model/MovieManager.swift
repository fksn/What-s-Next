//
//  MovieManager.swift
//  Filmes Teste
//
//  Created by Francisco Neto on 16/06/22.
//

import Foundation

protocol MovieManagerDelegate{
    func didUpdateMovie(_ movieManager: MovieManager, movie: MovieModel)
    func didFailWithError(error: Error)
}

class MovieManager {
    let apiKey = "k_t448asfh"
    var delegate: MovieManagerDelegate?
    func fetchData(link: String) {
        let urlString = "\(link)\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let movie = self.parseJSON(safeData) {
                        self.delegate?.didUpdateMovie(self, movie: movie)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ movieData: Data) -> MovieModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MoviesData.self, from: movieData)
            let moviesFromData = decodedData.items
            let movies = MovieModel(itens: moviesFromData)
            return movies
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
