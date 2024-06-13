//
//  DetailsInteractor.swift
//  IMDbApp
//
//  Created by Billy Joel on 17.01.2024.
//

import Foundation

protocol DetailsInteractorProtocol {
    func viewDidLoad()
    func didTapCrossButton()
}

protocol DetailsInteractorCoordinatorDelegate: AnyObject {
    func detailsFlowCoordinatorDidCancel()
}

final class DetailsInteractor {
    
    private let presenter: DetailsPresenterProtocol
    private var movieId: Int
    weak var coordiantor: DetailsInteractorCoordinatorDelegate?
    private var detailsModel: DetailsModel?
    private var videoType: VideoType
    
    init(presenter: DetailsPresenterProtocol, movieId: Int, videoType: VideoType) {
        self.presenter = presenter
        self.movieId = movieId
        self.videoType = videoType
    }
}

extension DetailsInteractor: DetailsInteractorProtocol {
    
    func viewDidLoad() {
        
        let url = URL(string: "https://api.themoviedb.org/3/\(videoType.url)/\(movieId)?api_key=9606d0f761d04a5129e2a253001f9d18")
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url!)) { data, response, error in
            guard let data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(DetailsModel.self, from: data)
                self.detailsModel = decodedData
                
                DispatchQueue.main.async {
                    self.presenter.presentDetailsModel(decodedData)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    func didTapCrossButton() {
        coordiantor?.detailsFlowCoordinatorDidCancel()
    }
}
