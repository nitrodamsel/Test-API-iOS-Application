//
//  LoginView.swift
//  IMDbApp
//
//  Created by Billy Joel on 24.01.2024.
//

import UIKit

class LoginView: UIView {
    
    private let logoImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "loginlogo"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let welcomeLabel: UILabel = {
        let view = UILabel()
        view.text = "Welcome to IMDb"
        view.font = UIFont.boldSystemFont(ofSize: 25)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 0
        view.textColor = .white
        return view
    }()
    
    private let usernameHolderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 5
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let passwordHolderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let usernameTextField: CustomTextField = {
        let view = CustomTextField()
        view.textColor = .white
        view.placeholder = "Username"
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        view.leftViewMode = .always
        return view
    }()
    
    let passwordTextField: CustomTextField = {
        let view = CustomTextField()
        view.textColor = .white
        view.placeholder = "Password"
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.isSecureTextEntry = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        view.leftViewMode = .always
        return view
    }()
    
    private let infoIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "info"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let infoLabel: UILabel = {
        let view = UILabel()
        view.text = "Passwords must be at least 8 characters."
        view.font = UIFont.boldSystemFont(ofSize: 13)
        view.textColor = .white
        view.numberOfLines = 0
        view.textAlignment = .natural
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [infoIcon, infoLabel])
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let signInButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Sign in", for: .normal)
        view.backgroundColor = .launch
        view.setTitleColor(.white, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .black
        addSubview(logoImageView)
        addSubview(welcomeLabel)
        usernameHolderView.addSubview(usernameTextField)
        passwordHolderView.addSubview(passwordTextField)
        addSubview(usernameHolderView)
        addSubview(passwordHolderView)
        addSubview(stackView)
        addSubview(signInButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 15),
            welcomeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            
            usernameTextField.topAnchor.constraint(equalTo: usernameHolderView.topAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: usernameHolderView.trailingAnchor),
            usernameTextField.leadingAnchor.constraint(equalTo: usernameHolderView.leadingAnchor),
            usernameTextField.bottomAnchor.constraint(equalTo: usernameHolderView.bottomAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordHolderView.topAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordHolderView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordHolderView.trailingAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordHolderView.bottomAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            usernameHolderView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 30),
            usernameHolderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            usernameHolderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            passwordHolderView.topAnchor.constraint(equalTo: usernameHolderView.bottomAnchor, constant: 15),
            passwordHolderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            passwordHolderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            stackView.topAnchor.constraint(equalTo: passwordHolderView.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            stackView.heightAnchor.constraint(equalToConstant: 20),
            
            signInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            signInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            signInButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            signInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension LoginView: UITextFieldDelegate {
    
}

class CustomTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 10, dy: 15)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 10, dy: 15)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 10, dy: 15)
    }
}
