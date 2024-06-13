//
//  HomePageViewController.swift
//  IMDbApp
//
//  Created by Billy Joel on 22.01.2024.
//

import UIKit

protocol HomePageViewControllerProtocol: AnyObject {
    func display(_ viewModels: [VideoSectionViewModel])
}

class HomePageViewController: UIViewController {
    
    private let interactor: HomePageInteractorProtocol
    private let homePageView = HomePageView()
    private var sectionList: [VideoSectionViewModel] = []
    
    override func loadView() {
        view = homePageView
    }
    
    init(interactor: HomePageInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homePageView.tableView.dataSource = self
        homePageView.tableView.delegate = self
        
        interactor.viewDidLoad()
    }
}

extension HomePageViewController: HomePageViewControllerProtocol {
    func display(_ viewModels: [VideoSectionViewModel]) {
        
        self.sectionList = viewModels
        homePageView.tableView.reloadData()
    }
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource, HomePageTableViewCellDelegate {
    
    func didTapMoreButton(videoType: VideoType) {
        interactor.didTapMoreButton(videoType: videoType)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomePageTableViewCell
        let section = sectionList[indexPath.row]
        cell.reloadWith(section)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
