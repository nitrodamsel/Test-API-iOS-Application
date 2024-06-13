//
//  PopularListFlowCoordinator.swift
//  IMDbApp
//
//  Created by Billy Joel on 17.01.2024.
//

import UIKit

protocol PopularListFlowCoordinatorProtocol {
    func start()
}

protocol PopularListFlowCoordinatorDelegate {
    func popularListFlowCoordinatorDidFinish()
}

final class PopularListFlowCoordinator: PopularListFlowCoordinatorProtocol {
    
    private let window: UIWindow
    private let delegate: PopularListFlowCoordinatorDelegate
    private let navigationController = UINavigationController()
    private var detailsFlowCoordinator: DetailsFlowCoordinator?
    private var videoType: VideoType
    private var presentingViewController: UINavigationController
    
    init(window: UIWindow, delegate: PopularListFlowCoordinatorDelegate, videoType: VideoType, presentingViewController: UINavigationController) {
        self.window = window
        self.delegate = delegate
        self.videoType = videoType
        self.presentingViewController = presentingViewController
    }
    
    func start() {
        let popularListViewController = PopularListViewController.build(coordinator: self, videoType: videoType)
        navigationController.viewControllers = [popularListViewController]
        presentingViewController.present(navigationController, animated: true)
    }
}

extension PopularListFlowCoordinator: PopularListInteractorCoordinatorDelegate {
    
    func popularListInteractorDidTapMovie(movieId: Int, videoType: VideoType) {
        detailsFlowCoordinator = DetailsFlowCoordinator(window: self.window, delegate: self, presentingViewController: self.navigationController, movieId: movieId, videoType: videoType)
        detailsFlowCoordinator?.start()
    }
}

extension PopularListFlowCoordinator: DetailsFlowCoordinatorDelegate {
    
    func detailsFlowCoordinatorDidCancel() {
        detailsFlowCoordinator = nil
    }
}
