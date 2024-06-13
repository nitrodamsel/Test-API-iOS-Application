//
//  DetailsView.swift
//  IMDbApp
//
//  Created by Billy Joel on 17.01.2024.
//

import UIKit

class DetailsView: UIView {
    
    private let detailsImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private let movieTitLeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 30)
        view.textColor = .white
        view.numberOfLines = 0
        return view
    }()
    
    private let movieSubtitleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [movieTitLeLabel, movieSubtitleLabel])
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 5
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let genresTitle: UILabel = {
        let view = UILabel()
        view.textColor = .year
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.numberOfLines = 0
        view.text = "Genres"
        return view
    }()
    
    private let genresSubTitle: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var genresStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [genresTitle, genresSubTitle])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let revenueTitle: UILabel = {
        let view = UILabel()
        view.textColor = .year
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.numberOfLines = 0
        view.text = "Revenue"
        return view
    }()
    
    private let revenueSubTitle: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.numberOfLines = 0
        view.textAlignment = .natural
        return view
    }()
    
    private lazy var revenueStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [revenueTitle, revenueSubTitle])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
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
        addSubview(detailsImageView)
        addSubview(stackView)
        addSubview(collectionView)
        addSubview(genresStackView)
        addSubview(revenueStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            detailsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailsImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            detailsImageView.heightAnchor.constraint(equalToConstant: 250),
            
            stackView.topAnchor.constraint(equalTo: detailsImageView.bottomAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 60),
            
            genresStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            genresStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            genresStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            revenueStackView.topAnchor.constraint(equalTo: genresStackView.bottomAnchor, constant: 20),
            revenueStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            revenueStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
    
    func reloadWith(_ detailsModel: DetailsModel, genresText: String, revenueText: String) {
        
        movieTitLeLabel.text = detailsModel.title
        movieSubtitleLabel.text = detailsModel.overview
        genresSubTitle.text = genresText
        revenueSubTitle.text = revenueText
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: "https://image.tmdb.org/t/p/w\(500)\(detailsModel.backdropPath ?? "")")!), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.detailsImageView.image = image
                }
            }
        }
    }
}

