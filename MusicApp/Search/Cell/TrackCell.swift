//
//  TrackCell.swift
//  MusicApp
//
//  Created by Liz-Mary on 31.07.2023.
//

import UIKit

protocol TrackCellViewModel {
    var iconURLString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
}

class TrackCell: UITableViewCell {

    var artistNameLabel: UILabel = {
        var artistName = UILabel()
        artistName.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        artistName.textColor = .systemGray2
        artistName.translatesAutoresizingMaskIntoConstraints = false
        return artistName
    }()
    
    var trackNameLabel: UILabel = {
        var trackName = UILabel()
        trackName.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        trackName.translatesAutoresizingMaskIntoConstraints = false
        return trackName
    }()
    
    var collectionNameLabel: UILabel = {
        var collection = UILabel()
        collection.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        collection.textColor = .systemGray2
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
     var images: UIImageView = {
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
        addSubview(collectionNameLabel)
    }
    
    func setupConstrain() {
        
        NSLayoutConstraint.activate([
            images.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            images.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 21),
            images.widthAnchor.constraint(equalToConstant: 60),
            images.heightAnchor.constraint(equalToConstant: 60),
            
            trackNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 13),
            trackNameLabel.leadingAnchor.constraint(equalTo: images.trailingAnchor, constant: 10),
            trackNameLabel.widthAnchor.constraint(equalToConstant: 260),
            
            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 2),
            artistNameLabel.leadingAnchor.constraint(equalTo: images.trailingAnchor, constant: 10),
            artistNameLabel.widthAnchor.constraint(equalToConstant: 260),
            
            collectionNameLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 3),
            collectionNameLabel.leadingAnchor.constraint(equalTo: images.trailingAnchor, constant: 10),
            collectionNameLabel.widthAnchor.constraint(equalToConstant: 260)
        ])
    }
    
    func set(viewModel: TrackCellViewModel) {
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
    
    }
}
