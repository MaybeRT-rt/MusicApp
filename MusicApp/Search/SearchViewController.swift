//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Liz-Mary on 30.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchDisplayLogic: AnyObject {
    func displayData(viewModel: Search.Model.ViewModel.ViewModelData)
}

class SearchViewController: UIViewController, SearchDisplayLogic {
    
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic)?
    
    let searchController = UISearchController(searchResultsController: nil)
    private var searchViewModel = SearchViewModel.init(cell: [])
    
    private var timer: Timer?
    
    private lazy var tableView: UITableView = {
        let searchTV = UITableView.init(frame: .zero, style: .grouped)
        searchTV.translatesAutoresizingMaskIntoConstraints = false
        
        return searchTV
    }()
    
    // MARK: Object lifecycle
    
    
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = SearchInteractor()
        let presenter             = SearchPresenter()
        let router                = SearchRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setup()
        
        setupSearchBar()
        setupTableView()
        addedSubview()
        setupContrain()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.delegate = self
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addedSubview() {
        view.addSubview(tableView)
    }
    
    func setupContrain() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    func displayData(viewModel: Search.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .some:
            print("viewController .some")
        case .displayTracks(let searchViewModel):
            print("viewController .displayTack")
            self.searchViewModel = searchViewModel
            tableView.reloadData()
        }
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (_) in
            self.interactor?.makeRequest(request: Search.Model.Request.RequestType.getTracks(searchText: searchText))
        }
    }
}

//MARK: - TableView

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.cell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrackCell = (tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)) as! TrackCell
        let cellViewModel = searchViewModel.cell[indexPath.row]
        cell.textLabel?.text = "\(cellViewModel.artistName)\n\(cellViewModel.trackName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = UIImage(named: "bug")
        
        return cell
    }
}

