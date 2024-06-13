//
//  DetailsViewController.swift
//  IMDbApp
//
//  Created by Billy Joel on 17.01.2024.
//

import UIKit

protocol DetailsViewControllerProtocol: AnyObject {
    func displayDetailsModel(_ detailsModel: DetailsModel, genreNames: String, revenueText: String, collectionData: [DetailsCollectionViewCellViewModel])
}

class DetailsViewController: UIViewController {
    
    private let interactor: DetailsInteractorProtocol
    private let detailsView = DetailsView()
    private var detailsModel: DetailsModel?
    private var collectionData: [DetailsCollectionViewCellViewModel] = []
    
    override func loadView() {
        view = detailsView
    }
    
    init(interactor: DetailsInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsView.collectionView.dataSource = self
        detailsView.collectionView.delegate = self
        
        configureNavigationController()
        interactor.viewDidLoad()
    }
    
    private func configureNavigationController() {
        let apperance = UINavigationBarAppearance()
        self.title = "Details"
        apperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        apperance.backgroundColor = .black
        navigationController?.navigationBar.standardAppearance = apperance
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc private func didTapClose() {
        interactor.didTapCrossButton()
    }
}

extension DetailsViewController: DetailsViewControllerProtocol {
    
    func displayDetailsModel(_ detailsModel: DetailsModel, genreNames: String, revenueText: String, collectionData: [DetailsCollectionViewCellViewModel]) {
        self.detailsModel = detailsModel
        self.collectionData = collectionData
        detailsView.reloadWith(detailsModel, genresText: genreNames, revenueText: revenueText)
        detailsView.collectionView.reloadData()
    }
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DetailsCollectionViewCell
        let viewModel = collectionData[indexPath.row]
        cell.reloadWith(viewModel: viewModel)
        return cell
    }
}
