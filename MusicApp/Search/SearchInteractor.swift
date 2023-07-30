//
//  SearchInteractor.swift
//  MusicApp
//
//  Created by Liz-Mary on 30.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
    func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {
    
    var presenter: SearchPresentationLogic?
    var service: SearchService?
    
    func makeRequest(request: Search.Model.Request.RequestType) {
        if service == nil {
            service = SearchService()
        }
        
        switch request {
        case .some:
            print("interactor .some")
            presenter?.presentData(response: Search.Model.Response.ResponseType.presentTracks)
        case .getTracks:
            print("interactor .getTracks")
            presenter?.presentData(response: .presentTracks)
        }
    }
}
