//
//  DetailsCollectionViewCell.swift
//  IMDbApp
//
//  Created by Billy Joel on 18.01.2024.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    private let icon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.heightAnchor.constraint(equalToConstant: 25).isActive = true
        return view
    }()
    
    private let title: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.textColor = .white
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [icon, title])
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 2
        view.alignment = .fill
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
        contentView.backgroundColor = .black
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    func reloadWith(viewModel: DetailsCollectionViewCellViewModel) {
        icon.image = UIImage(named: viewModel.iconName)
        title.text = viewModel.title
    }
}
