//
//  DetailsViewController+Build.swift
//  IMDbApp
//
//  Created by Billy Joel on 17.01.2024.
//

import UIKit

extension DetailsViewController {
    
    static func build(coordinator: DetailsInteractorCoordinatorDelegate, movieId: Int, videoType: VideoType) -> UIViewController {
        let presenter = DetailsPresenter()
        let interactor = DetailsInteractor(presenter: presenter, movieId: movieId, videoType: videoType)
        interactor.coordiantor = coordinator
        let viewController = DetailsViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
