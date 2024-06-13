//
//  HomePageInteractor.swift
//  IMDbApp
//
//  Created by Billy Joel on 22.01.2024.
//

import Foundation

protocol HomePageInteractorProtocol {
    func viewDidLoad()
    func didTapMoreButton(videoType: VideoType)
}

protocol HomePageInteractorCoordinatorDelegate: AnyObject {
    func didTapMoreButton(videoType: VideoType)
}

final class HomePageInteractor {
    
    private let presenter: HomePagePresenterProtocol
    weak var coordinator: HomePageInteractorCoordinatorDelegate?
    private var movieList: MovieModel?
    private var sectionList: [VideoSectionViewModel] = []
    private let dispatchGroup = DispatchGroup()
    
    init(presenter: HomePagePresenterProtocol) {
        self.presenter = presenter
    }
}

extension HomePageInteractor: HomePageInteractorProtocol {
    
    func viewDidLoad() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=9606d0f761d04a5129e2a253001f9d18")
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url!)) { data, response, error in
            guard let data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(MovieModel.self, from: data)
                self.movieList = decodedData
                let section = VideoSectionViewModel(type: .movies, videos: decodedData.results!, cellStyle: .vertical)
                self.sectionList.append(section)
                self.dispatchGroup.leave()
                
            } catch {
                print("Error: \(error)")
            }
        }
        dispatchGroup.enter()
        task.resume()
        
        let url2 = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=9606d0f761d04a5129e2a253001f9d18")
        
        let task2 = URLSession.shared.dataTask(with: URLRequest(url: url2!)) { data, response, error in
            guard let data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(MovieModel.self, from: data)
                self.movieList = decodedData
                let section = VideoSectionViewModel(type: .series, videos: decodedData.results!, cellStyle: .horizontal)
                self.sectionList.append(section)
                self.dispatchGroup.leave()
            } catch {
                print("Error2: \(error)")
            }
        }
        dispatchGroup.enter()
        task2.resume()
        
        dispatchGroup.notify(queue: .main) {
            self.presenter.presentList(self.sectionList.sorted {$0.type.rawValue < $1.type.rawValue})
        }
    }
    func didTapMoreButton(videoType: VideoType) {
        
        switch videoType {
        case .movies:
            coordinator?.didTapMoreButton(videoType: .movies)
        
        case .series:
            coordinator?.didTapMoreButton(videoType: .series)
        }
    }
}
