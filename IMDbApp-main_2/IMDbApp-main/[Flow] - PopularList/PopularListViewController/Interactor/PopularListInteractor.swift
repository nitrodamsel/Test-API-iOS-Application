//
//  PopularListInteractor.swift
//  IMDbApp
//
//  Created by Billy Joel on 17.01.2024.
//

import Foundation

protocol PopularListInteractorProtocol {
    func viewDidLoad()
    func didTapMovie(_ index: Int)
}

protocol PopularListInteractorCoordinatorDelegate: AnyObject {
    func popularListInteractorDidTapMovie(movieId: Int, videoType: VideoType)
}

final class PopularListInteractor {
    
    private let presenter: PopularListPresenterProtocol
    weak var coordinator: PopularListInteractorCoordinatorDelegate?
    private var movieList: MovieModel?
    private var videoType: VideoType?
    
    init(presenter: PopularListPresenterProtocol, videoType: VideoType) {
        self.presenter = presenter
        self.videoType = videoType
    }
}

extension PopularListInteractor: PopularListInteractorProtocol {
   
    func viewDidLoad() {
        
        let url = URL(string: "https://api.themoviedb.org/3/\(videoType!.url)/popular?api_key=9606d0f761d04a5129e2a253001f9d18")
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url!)) { data, response, error in
            guard let data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(MovieModel.self, from: data)
                self.movieList = decodedData
                
                DispatchQueue.main.async {
                    self.presenter.presentMovieList(decodedData)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    func didTapMovie(_ index: Int) {
        guard let movie = movieList?.results?[index] else { return }
        guard let videoType else { return }
        coordinator?.popularListInteractorDidTapMovie(movieId: movie.id, videoType: videoType)
    }
}
