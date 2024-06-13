//
//  PopularListTableViewCell.swift
//  IMDbApp
//
//  Created by Billy Joel on 17.01.2024.
//

import UIKit

class PopularListTableViewCell: UITableViewCell {
    
    let cardView: UIView = {
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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let movieTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textAlignment = .natural
        view.numberOfLines = 0
        view.textColor = .white
        return view
    }()
    
    private let movieSubtitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.textColor = .lightGray
        view.textAlignment = .natural
        view.numberOfLines = 3
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [movieTitleLabel, movieSubtitleLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 2
        return view
    }()
    
    private let yearLabel: UILabel = {
        let view = UILabel()
        view.textColor = .year
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.text = "Year"
        return view
    }()
    
    private let yearSubtitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.textColor = .white
        return view
    }()
    
    private lazy var yearStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [yearLabel, yearSubtitleLabel])
        view.axis = .vertical
        view.spacing = 4
        view.distribution = .fill
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ratingLabel: UILabel = {
        let view = UILabel()
        view.textColor = .year
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.text = "Rating"
        return view
    }()
    
    private let ratingSubtitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.textColor = .white
        return view
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [ratingLabel, ratingSubtitleLabel])
        view.axis = .vertical
        view.spacing = 4
        view.distribution = .fill
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "chevron"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        contentView.addSubview(cardView)
        cardView.addSubview(movieImageView)
        cardView.addSubview(stackView)
        cardView.addSubview(yearStackView)
        cardView.addSubview(ratingStackView)
        cardView.addSubview(iconImageView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            movieImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            movieImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
            movieImageView.heightAnchor.constraint(equalToConstant: 170),
            
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -10),
            
            yearStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            yearStackView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            yearStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -15),
            
            ratingStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            ratingStackView.leadingAnchor.constraint(equalTo: yearStackView.trailingAnchor, constant: 8),
            ratingStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -15),
            
            iconImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            iconImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 15),
            iconImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    func reloadWith(movieList: MovieViewModel) {
        movieTitleLabel.text = movieList.title
        movieSubtitleLabel.text = movieList.overview
        yearSubtitleLabel.text = movieList.relaseDate
        ratingSubtitleLabel.text = "\(movieList.voteAverage)"
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: "https://image.tmdb.org/t/p/w\(200)\(movieList.posterPath ?? "")")!), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            }
        }
    }
}
