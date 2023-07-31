//
//  TrackCell.swift
//  MusicApp
//
//  Created by Liz-Mary on 31.07.2023.
//

import UIKit

class TrackCell: UITableViewCell {

    private lazy var artistNameLabel: UILabel = {
        var artistName = UILabel()
        artistName.translatesAutoresizingMaskIntoConstraints = false
        return artistName
    }()
    
    private lazy var trackNameLabel: UILabel = {
        var trackName = UILabel()
        trackName.translatesAutoresizingMaskIntoConstraints = false
        return trackName
    }()
    
    private lazy var images: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addedSubview()
        setupConstrain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addedSubview() {
        addSubview(images)
        addSubview(trackNameLabel)
        addSubview(artistNameLabel)
    }
    
    func setupConstrain() {
        
        NSLayoutConstraint.activate([
            images.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            images.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            images.widthAnchor.constraint(equalToConstant: 50),
            images.heightAnchor.constraint(equalToConstant: 50),
            
            trackNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            trackNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 132),
            trackNameLabel.widthAnchor.constraint(equalToConstant: 100),
            trackNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.safeAreaLayoutGuide.topAnchor, constant: 30),
            artistNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 132),
            artistNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            artistNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
