//
//  PlayerController.swift
//  HaloStats
//
//  Created by Zachary Frew on 7/17/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class PlayerController {
    
    // MARK: - Properties
    static let baseURL = URL(string: "https://www.haloapi.com/stats/h5")
    // "https://www.haloapi.com/stats/h5/servicerecords/arena?players={players}"
    
    // MARK: - Methods
    static func searchForPlayer(by searchTerm: String, completion: @escaping((Player?) -> Void)) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.haloapi.com"
        urlComponents.path = "/stats/h5/servicerecords/arena"
        let arenaQuery = URLQueryItem(name: "players", value: searchTerm)
        urlComponents.queryItems = [arenaQuery]
        
        guard let url = urlComponents.url else { completion(nil) ; return }
        
        print(url)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(apiKey1, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
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
                print(playerDictionary)
                let player = Player(playerDictionary: playerDictionary)
                print(player)
                completion(player)
            } catch {
                print("Error decoding Player: \(error)")
            }
        }
        dataTask.resume()
    }
    
//    static func getPlayerImage(_ player: Player, completion: @escaping ((UIImage?) -> Void)) {
//        let playerImagestring = "\(player.playerImage.spartanImageURLAsString)/\(player)/spartan"
//        guard let urlForImage = URL(string: playerImagestring) else {
//            print("No URL for player image")
//            completion(nil)
//            return
//        }
//
//        let dataTask = URLSession.shared.dataTask(with: urlForImage) { (data, response, error) in
//            if let error = error {
//                print("Error getting Player image: \(error.localizedDescription)")
//                completion(nil)
//                return
//            }
//
//            if let response = response {
//                print("Response: \(response)")
//                completion(nil)
//                return
//            }
//
//            guard let data = data else {
//                print("No data was received for Player image")
//                completion(nil)
//                return
//            }
//
//            let image = UIImage(data: data)
//            completion(image)
//        }
//        dataTask.resume()
//    }
    
}
