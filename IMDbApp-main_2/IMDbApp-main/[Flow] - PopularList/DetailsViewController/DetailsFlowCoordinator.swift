//
//  DetailsFlowCoordinator.swift
//  IMDbApp
//
//  Created by Billy Joel on 17.01.2024.
//

import UIKit

protocol DetailsFlowCoordinatorProtocol {
    func start()
}

protocol DetailsFlowCoordinatorDelegate {
    func detailsFlowCoordinatorDidCancel()
}

final class DetailsFlowCoordinator: NSObject, DetailsFlowCoordinatorProtocol {
    
    private let window: UIWindow
    private let delegate: DetailsFlowCoordinatorDelegate
    private var presentingViewController: UINavigationController
    private var navigationController = UINavigationController()
    private var movieId: Int
    private var videoType: VideoType

    init(window: UIWindow, delegate: DetailsFlowCoordinatorDelegate, presentingViewController: UINavigationController, movieId: Int, videoType: VideoType) {
        self.window = window
        self.delegate = delegate
        self.presentingViewController = presentingViewController
        self.movieId = movieId
        self.videoType = videoType
    }
    
    func start() {
        let detailsViewController = DetailsViewController.build(coordinator: self, movieId: movieId, videoType: videoType)
        navigationController.viewControllers = [detailsViewController]
        navigationController.presentationController?.delegate = self
        presentingViewController.present(navigationController, animated: true)
    }
}

extension DetailsFlowCoordinator: UIAdaptivePresentationControllerDelegate {
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate.detailsFlowCoordinatorDidCancel()
    }
}

extension DetailsFlowCoordinator: DetailsInteractorCoordinatorDelegate {
    
    func detailsFlowCoordinatorDidCancel() {
        presentingViewController.dismiss(animated: true)
        delegate.detailsFlowCoordinatorDidCancel()
    }
}
