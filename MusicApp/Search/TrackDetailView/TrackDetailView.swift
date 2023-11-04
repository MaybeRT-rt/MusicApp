//
//  TrackDetailView.swift
//  MusicApp
//
//  Created by Liz-Mary on 04.11.2023.
//

import UIKit

class TrackDetailView: UIView {
    
    lazy var stackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.backgroundColor = .lightGray
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(stackView)
    }
}
