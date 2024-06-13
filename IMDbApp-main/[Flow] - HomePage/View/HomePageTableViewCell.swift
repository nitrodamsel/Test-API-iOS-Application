//
//  HomePageTableViewCell.swift
//  IMDbApp
//
//  Created by Billy Joel on 22.01.2024.
//

import UIKit

protocol HomePageTableViewCellDelegate: AnyObject {
    func didTapMoreButton(videoType: VideoType)
}

class HomePageTableViewCell: UITableViewCell {
    
    private var viewModel: VideoSectionViewModel?
    private var movieViewModel: [Video] = []
    weak var delegate: HomePageTableViewCellDelegate?
    var videoType: VideoType?
    
    private let title: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 30)
        view.textColor = .white
        return view
    }()
    
    private lazy var titleStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [title, moreButton])
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 4
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
        view.register(HomePageMoviesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.register(HomePageSeriesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleStackView, collectionView])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let moreButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("more", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        view.setTitleColor(.year, for: .normal)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapMoreButton() {
        guard let videoType else { return }
        delegate?.didTapMoreButton(videoType: videoType)
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        contentView.addSubview(contentStackView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            moreButton.widthAnchor.constraint(equalToConstant: 100),
            
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            collectionView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func reloadWith(_ viewModel: VideoSectionViewModel) {
        title.text = viewModel.type.title
        self.viewModel = viewModel
        self.movieViewModel = viewModel.videos
        self.collectionView.reloadData()
        self.videoType = viewModel.type
    }
}

extension HomePageTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        switch viewModel?.cellStyle {
        
        case .vertical:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomePageMoviesCollectionViewCell
            let viewModel = movieViewModel[indexPath.row]
            cell.reloadWith(movieList: viewModel)
            return cell
            
        case .horizontal:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomePageSeriesCollectionViewCell
            let viewModel = movieViewModel[indexPath.row]
            cell.reloadWith(seriesList: viewModel)
            return cell
            
        case .none:
            let cell = UICollectionViewCell()
            return cell
        }
    }
}
