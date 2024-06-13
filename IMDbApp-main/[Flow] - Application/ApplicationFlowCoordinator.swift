//
//  ApplicationFlowCoordinator.swift
//  IMDbApp
//
//  Created by Billy Joel on 17.01.2024.
//

import UIKit

protocol ApplicationFlowCoordinatorProtocol: AnyObject {
    func start()
}

final class ApplicationFlowCoordinator: ApplicationFlowCoordinatorProtocol {
    
    private let window: UIWindow
    private var loginFlowCoordinator: LoginFlowCoordinatorProtocol?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        loginFlowCoordinator = LoginFlowCoordinator(window: self.window, delegate: self)
        loginFlowCoordinator?.start()
    }
}

extension ApplicationFlowCoordinator: LoginFlowCoordinatorDelegate {
    
}
