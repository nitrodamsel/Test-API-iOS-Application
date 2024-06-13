//
//  HomePageFlowCoordinator.swift
//  IMDbApp
//
//  Created by Billy Joel on 22.01.2024.
//

import Foundation
import UIKit

protocol HomePageFlowCoordinatorProtocol {
    func start()
}

protocol HomePageFlowCoordinatorDelegate {
    func homePageFlowCoordinatorDidFinish()
}

final class HomePageFlowCoordinator: HomePageFlowCoordinatorProtocol {
    
    private let window: UIWindow
    private let delegate: HomePageFlowCoordinatorDelegate
    private let navigationController = UINavigationController()
    private var popularListFlowCoordinator: PopularListFlowCoordinator?
    
    init(window: UIWindow, delegate: HomePageFlowCoordinatorDelegate) {
        self.window = window
        self.delegate = delegate
    }
    
    func start() {
        let homePageViewController = HomePageViewController.build(coordinator: self)
        navigationController.viewControllers = [homePageViewController]
        self.window.rootViewController = navigationController
    }
}
extension HomePageFlowCoordinator: HomePageInteractorCoordinatorDelegate {
    
    func didTapMoreButton(videoType: VideoType) {
        popularListFlowCoordinator = PopularListFlowCoordinator(window: self.window, delegate: self, videoType: videoType, presentingViewController: self.navigationController)
        popularListFlowCoordinator?.start()
    }
}

extension HomePageFlowCoordinator: PopularListFlowCoordinatorDelegate {
    
    func popularListFlowCoordinatorDidFinish() {
        navigationController.dismiss(animated: true)
        delegate.homePageFlowCoordinatorDidFinish()
    }
}
