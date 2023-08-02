//
//  NetworkService.swift
//  MusicApp
//
//  Created by Liz-Mary on 27.07.2023.
//

import UIKit
import Alamofire

class NetworkService {
    
    func fetchTracks(searchText: String, complition: @escaping(SearchResponse?) -> Void) {
        
        let url = "https://itunes.apple.com/search"
        let parameters = ["term":"\(searchText)", "limit":"10", "media":"music"]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (responseDatas) in
            if let error = responseDatas.error {
                print("error reveiced responsing data \(error.localizedDescription)")
                complition(nil)
                return
            }
            guard let data = responseDatas.data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let objects = try decoder.decode(SearchResponse.self, from: data)
                print("objects, \(objects)")
                complition(objects)
                
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                complition(nil)
            }
        }
    }
}
