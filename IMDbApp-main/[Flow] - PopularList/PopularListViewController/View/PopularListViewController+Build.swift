//
//  PopularListViewController+Build.swift
//  IMDbApp
//
//  Created by Billy Joel on 17.01.2024.
//

import UIKit

extension PopularListViewController {
    
    static func build(coordinator: PopularListInteractorCoordinatorDelegate, videoType: VideoType) -> UIViewController {
        let presenter = PopularListPresenter()
        let interactor = PopularListInteractor(presenter: presenter, videoType: videoType)
        interactor.coordinator = coordinator
        let viewController = PopularListViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
