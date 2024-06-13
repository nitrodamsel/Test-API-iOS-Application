//
//  HomePageSeriesCollectionViewCell.swift
//  IMDbApp
//
//  Created by Billy Joel on 22.01.2024.
//

import UIKit

class HomePageSeriesCollectionViewCell: UICollectionViewCell {
    
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
    
    private let seriesImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let seriesTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textAlignment = .natural
        view.numberOfLines = 0
        view.textColor = .white
        return view
    }()
    
    private let seriesSubtitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 13)
        view.textColor = .lightGray
        view.textAlignment = .natural
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var titleStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [seriesTitleLabel, seriesSubtitleLabel])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [seriesImageView, titleStackView])
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .top
        view.spacing = 12
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
        self.backgroundColor = .clear
        contentView.addSubview(cardView)
        cardView.addSubview(seriesImageView)
        cardView.addSubview(contentStackView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 220),
            cardView.widthAnchor.constraint(equalToConstant: 240),
            
            seriesImageView.heightAnchor.constraint(equalToConstant: 140),
            seriesImageView.widthAnchor.constraint(equalToConstant: 100),
            
            contentStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            contentStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            contentStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10),
        ])
    }
    
    func reloadWith(seriesList: Video) {
        
        seriesTitleLabel.text = seriesList.name
        seriesSubtitleLabel.text = seriesList.overview
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: "https://image.tmdb.org/t/p/w\(200)\(seriesList.backdropPath ?? "")")!), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.seriesImageView.image = image
                }
            }
        }
    }
}
