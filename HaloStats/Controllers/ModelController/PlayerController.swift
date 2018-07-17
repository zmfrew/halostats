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
        let baseURLAsString = "https://www.haloapi.com/stats/h5/servicerecords/arena?players="
        let urlAsString = baseURLAsString + searchTerm.lowercased()
 
        
        guard let url = URL(string: urlAsString) else {
            print("URL was not valid")
            completion(nil)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
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
                let jsonDecoder = JSONDecoder()
                let player = try jsonDecoder.decode(Player.self, from: data)
                completion(player)
            } catch {
                print("Error decoding Player: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
    static func getPlayerImage(_ player: Player, completion: @escaping ((UIImage?) -> Void)) {
        let playerImagestring = "\(player.playerImage.spartanImageURLAsString)/\(player)/spartan"
        guard let urlForImage = URL(string: playerImagestring) else {
            print("No URL for player image")
            completion(nil)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlForImage) { (data, _, error) in
            if let error = error {
                print("Error getting Player image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data was received for Player image")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }
        dataTask.resume()
    }
    
}
