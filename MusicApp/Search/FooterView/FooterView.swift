//
//  FooterView.swift
//  MusicApp
//
//  Created by Liz-Mary on 02.08.2023.
//

import UIKit

class FooterView: UIView {
    
    private var mylabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .systemGray3
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setuрElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setuрElements() {
        addSubview(mylabel)
        addSubview(loader)
        
        NSLayoutConstraint.activate([
        loader.topAnchor.constraint(equalTo: topAnchor, constant: 15),
        loader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        loader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        
        mylabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        mylabel.topAnchor.constraint(equalTo: loader.bottomAnchor, constant: 10)
        ])
    }
    
    func showLoader() {
        loader.startAnimating()
        mylabel.text = "Loading"
    }
    
    func hideLoader() {
        loader.stopAnimating()
        mylabel.text = ""
    }
    
}
