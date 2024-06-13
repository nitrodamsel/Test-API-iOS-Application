//
//  LoginFlowCoordinator.swift
//  IMDbApp
//
//  Created by Billy Joel on 24.01.2024.
//

import Foundation
import UIKit

protocol LoginFlowCoordinatorProtocol {
    func start()
}

protocol LoginFlowCoordinatorDelegate {
    
}

final class LoginFlowCoordinator: LoginFlowCoordinatorProtocol {
    
    private let window: UIWindow
    private let delegate: LoginFlowCoordinatorDelegate
    private let navigationController = UINavigationController()
    private var homePageFlowCoordinator: HomePageFlowCoordinator?
    
    init(window: UIWindow, delegate: LoginFlowCoordinatorDelegate) {
        self.window = window
        self.delegate = delegate
    }
    
    func start() {
        let loginViewController = LoginViewController.build(coordinator: self)
        navigationController.viewControllers = [loginViewController]
        self.window.rootViewController = navigationController
    }
}

extension LoginFlowCoordinator: LoginInteractorCoordinatorDelegate {
    
    func didTapSignInButton() {
        homePageFlowCoordinator = HomePageFlowCoordinator(window: self.window, delegate: self)
        homePageFlowCoordinator?.start()
    }
}

extension LoginFlowCoordinator: HomePageFlowCoordinatorDelegate {
    func homePageFlowCoordinatorDidFinish() {
        
    }
}
