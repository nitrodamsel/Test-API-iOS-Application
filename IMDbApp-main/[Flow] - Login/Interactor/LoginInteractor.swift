//
//  LoginInteractor.swift
//  IMDbApp
//
//  Created by Billy Joel on 24.01.2024.
//

import Foundation

protocol LoginInteractorProtocol {
    func didTapSignInButton()
}

protocol LoginInteractorCoordinatorDelegate: AnyObject {
    func didTapSignInButton()
}

final class LoginInteractor {
    
    private let presenter: LoginPresenterProtocol
    weak var coordinator: LoginInteractorCoordinatorDelegate?
    
    init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
}

extension LoginInteractor: LoginInteractorProtocol {
    
    func didTapSignInButton() {
        coordinator?.didTapSignInButton()
    }
}
