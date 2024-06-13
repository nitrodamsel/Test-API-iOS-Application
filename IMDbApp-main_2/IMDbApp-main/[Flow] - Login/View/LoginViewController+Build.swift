//
//  LoginViewController+Build.swift
//  IMDbApp
//
//  Created by Billy Joel on 24.01.2024.
//

import Foundation
import UIKit

extension LoginViewController {
    
    static func build(coordinator: LoginInteractorCoordinatorDelegate) -> UIViewController {
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(presenter: presenter)
        interactor.coordinator = coordinator
        let viewController = LoginViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
