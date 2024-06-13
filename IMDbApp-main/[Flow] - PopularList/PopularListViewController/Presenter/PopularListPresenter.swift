//
//  PopularListPresenter.swift
//  IMDbApp
//
//  Created by Billy Joel on 17.01.2024.
//

import Foundation

protocol PopularListPresenterProtocol {
    func presentMovieList(_ movieList: MovieModel)
}

final class PopularListPresenter: PopularListPresenterProtocol {
    
    weak var viewController: PopularListViewControllerProtocol?
    
    func presentMovieList(_ movieList: MovieModel) {
        
        guard let results = movieList.results else {
            viewController?.displayMovieList(viewModels: [])
            return
        }
    
        let viewModels = results.map { movie in
            let titleOrName = movie.title?.isEmpty == false ? movie.title : movie.name
            let displayDate = movie.releaseDate ?? movie.firstAirDate ?? "Unkown"
            
            return MovieViewModel(id: movie.id, title: titleOrName ?? "", overview: movie.overview, relaseDate: String(displayDate.prefix(4)), voteAverage: movie.voteAverage, posterPath: movie.posterPath, name: movie.name)
        }
        viewController?.displayMovieList(viewModels: viewModels)
    }
}

