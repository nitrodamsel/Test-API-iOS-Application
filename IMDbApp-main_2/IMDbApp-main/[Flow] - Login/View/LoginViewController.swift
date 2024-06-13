//
//  LoginViewController.swift
//  IMDbApp
//
//  Created by Billy Joel on 24.01.2024.
//

import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    
}

class LoginViewController: UIViewController {
    
    private let interactor: LoginInteractorProtocol
    private let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    init(interactor: LoginInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.signInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)

    }
    
    @objc private func didTapSignInButton() {
        interactor.didTapSignInButton()
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    
}
