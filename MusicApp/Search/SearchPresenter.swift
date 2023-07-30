//
//  SearchPresenter.swift
//  MusicApp
//
//  Created by Liz-Mary on 30.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
    func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?
    
    func presentData(response: Search.Model.Response.ResponseType) {
        switch response {
        case .some:
            print("presenret .some")
        case .presentTracks:
            print("presenter .presentTrack")
            viewController?.displayData(viewModel: Search.Model.ViewModel.ViewModelData.displayTracks)
        }
    }
    
}
