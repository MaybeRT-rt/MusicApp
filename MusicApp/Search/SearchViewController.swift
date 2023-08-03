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
    
    private lazy var footerView = FooterView()
    
    // MARK: Object lifecycle
    
    
    
    // MARK: Setup
    
    // Функция настройки VIP-архитектуры
    
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
    
    // Настройка поисковой строки
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.delegate = self
    }
    
    // Настройка таблицы для отображения результатов поиска
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        
        tableView.register(TrackCell.self, forCellReuseIdentifier: "CellTrack")
        tableView.tableFooterView = footerView
        
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
    
    // Обработка данных для отображения в таблице
    func displayData(viewModel: Search.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayTracks(let searchViewModel):
            self.searchViewModel = searchViewModel
            tableView.reloadData()
            footerView.hideLoader()
        case .displayFooterView:
            footerView.showLoader()
        }
    }
}

//MARK: - UISearchBarDelegate
// Обработка события изменения текста в поисковой строке
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        // Запуск таймера для отложенного выполнения поискового запроса
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (_) in
            self.interactor?.makeRequest(request: Search.Model.Request.RequestType.getTracks(searchText: searchText))
        }
    }
}

//MARK: - TableView - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 84
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.cell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrackCell = tableView.dequeueReusableCell(withIdentifier: "CellTrack", for: indexPath) as! TrackCell
        let cellViewModel = searchViewModel.cell[indexPath.row]
        cell.images.backgroundColor = .blue
        cell.set(viewModel: cellViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please enter search term above.."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return searchViewModel.cell.count > 0 ? 0 : 250
    }
}

