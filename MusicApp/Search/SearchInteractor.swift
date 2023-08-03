//
//  SearchInteractor.swift
//  MusicApp
//
//  Created by Liz-Mary on 30.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
// Протокол для бизнес-логики экрана поиска
protocol SearchBusinessLogic {
    func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {
    
    var networkService = NetworkService()
    
    var presenter: SearchPresentationLogic?
    var service: SearchService?
    
    // Обработка запросов от презентера
    func makeRequest(request: Search.Model.Request.RequestType) {
        if service == nil {
            service = SearchService()
        }
        
        switch request {
        case .getTracks(let searchText):
            presenter?.presentData(response: .presentFooterView)
            // Запрос на получение треков с помощью сетевого сервиса (networkService)
            networkService.fetchTracks(searchText: searchText) { [weak self] (searchResponse) in
                self?.presenter?.presentData(response: .presentTracks(searchResponse: searchResponse))
            }
        }
    }
}
