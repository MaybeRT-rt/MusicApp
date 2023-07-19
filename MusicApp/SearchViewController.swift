//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Liz-Mary on 17.07.2023.
//

import UIKit
import Alamofire

class SearchViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let tracks = [TrackModel(trackName: "Love", artistName: "Jack"),
                      TrackModel(trackName: "Black", artistName: "B&W")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        setupSearchBar()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "indexId")
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.delegate = self
    }
    
}

extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "indexId", for: indexPath)
        let track = tracks[indexPath.row]
        cell.textLabel?.text = "\(track.trackName)\n\(track.artistName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = UIImage(named: "bug")
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        let url = "https://itunes.apple.com/search?term=\(searchText)"
        
        AF.request(url).responseData { (responseDatas) in
            if let error = responseDatas.error {
                print("error reveiced responsing data \(error.localizedDescription)")
                return
            }
            
            guard let data = responseDatas.data else { return }
            let someString = String(data: data, encoding: .utf8)
            print(someString ?? "")
        }
    }
}
