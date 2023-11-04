//
//  TrackDetailViewController.swift
//  MusicApp
//
//  Created by Liz-Mary on 04.11.2023.
//

import Foundation
import UIKit

class TrackDetailViewController: UIViewController {
    
    let trackDetailView = TrackDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(trackDetailView.stackView)
        
        NSLayoutConstraint.activate([
            trackDetailView.stackView.topAnchor.constraint(equalTo: view.topAnchor),
            trackDetailView.stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            trackDetailView.stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            trackDetailView.stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
        ])
    }
}
