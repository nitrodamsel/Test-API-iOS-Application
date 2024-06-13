//
//  PopularListViewController.swift
//  IMDbApp
//
//  Created by Billy Joel on 17.01.2024.
//

import UIKit

protocol PopularListViewControllerProtocol: AnyObject {
    func displayMovieList(viewModels: [MovieViewModel])
}

class PopularListViewController: UIViewController {
    
    private let interactor: PopularListInteractorProtocol
    private let popularListView = PopularListView()
    private var movieList: [MovieViewModel] = []
    
    override func loadView() {
        view = popularListView
    }
    
    init(interactor: PopularListInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popularListView.tableView.dataSource = self
        popularListView.tableView.delegate = self
        
        interactor.viewDidLoad()
    }
}

extension PopularListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PopularListTableViewCell
        let movie = movieList[indexPath.row]
        cell.reloadWith(movieList: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor.didTapMovie(indexPath.row)
    }
}

extension PopularListViewController: PopularListViewControllerProtocol {
    
    func displayMovieList(viewModels: [MovieViewModel]) {
        self.movieList = viewModels
        popularListView.tableView.reloadData()
    }
}
