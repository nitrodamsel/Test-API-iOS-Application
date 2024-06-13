//
//  HomePageViewController+Build.swift
//  IMDbApp
//
//  Created by Billy Joel on 22.01.2024.
//

import Foundation
import UIKit

extension HomePageViewController {
    
    static func build(coordinator: HomePageInteractorCoordinatorDelegate) -> UIViewController {
        let presenter = HomePagePresenter()
        let interactor = HomePageInteractor(presenter: presenter)
        interactor.coordinator = coordinator
        let viewController = HomePageViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
