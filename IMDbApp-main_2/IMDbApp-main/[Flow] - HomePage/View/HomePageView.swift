//
//  HomePageView.swift
//  IMDbApp
//
//  Created by Billy Joel on 22.01.2024.
//

import UIKit

class HomePageView: UIView {
    
    private let homeLabel: UILabel = {
        let view = UILabel()
        view.text = "Home"
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = UITableView.automaticDimension
        view.separatorStyle = .none
        view.allowsSelection = true
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = false
        view.register(HomePageTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .black
        addSubview(homeLabel)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            homeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 55),
            homeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            homeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
