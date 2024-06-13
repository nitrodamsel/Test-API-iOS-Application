//
//  HomePageMoviesCollectionViewCell.swift
//  IMDbApp
//
//  Created by Billy Joel on 22.01.2024.
//

import UIKit

class HomePageMoviesCollectionViewCell: UICollectionViewCell {
    
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .cell
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 5
        view.layer.masksToBounds = false
        return view
    }()
    
    private let movieImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let movieTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.textColor = .white
        return view
    }()
    
    private let movieSubtitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 11)
        view.textColor = .lightGray
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [movieImageView, movieTitleLabel, movieSubtitleLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 2
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
        self.backgroundColor = .clear
        contentView.addSubview(cardView)
        cardView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cardView.widthAnchor.constraint(equalToConstant: 130),
            cardView.heightAnchor.constraint(equalToConstant: 220),
            
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10),
            
            movieImageView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    func reloadWith(movieList: Video) {
        
        movieTitleLabel.text = movieList.title
        movieSubtitleLabel.text = movieList.overview
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: "https://image.tmdb.org/t/p/w\(200)\(movieList.backdropPath ?? "")")!), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            }
        }
    }
}
