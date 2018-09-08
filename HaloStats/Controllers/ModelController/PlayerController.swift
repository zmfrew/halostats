//
//  PlayerController.swift
//  HaloStats
//
//  Created by Zachary Frew on 7/17/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class PlayerController {
    
    // MARK: - Methods
    static func searchForPlayer(by searchTerm: String, completion: @escaping((Player?) -> Void)) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.haloapi.com"
        urlComponents.path = "/stats/h5/servicerecords/arena"
        let arenaQuery = URLQueryItem(name: "players", value: searchTerm)
        urlComponents.queryItems = [arenaQuery]
        
        guard let url = urlComponents.url else { completion(nil) ; return }
                
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(Constants.apiKey1, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print("Error with URL session: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data was found")
                completion(nil)
                return
            }
        
            do {
                guard let playerDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else { completion(nil) ; return }
                let player = Player(playerDictionary: playerDictionary)
                completion(player)
            } catch {
                print("Error decoding Player: \(error)")
            }
        }
        
        dataTask.resume()
    }
    
    
}
