//
//  PlayerImageController.swift
//  HaloStats
//
//  Created by Zachary Frew on 7/17/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class PlayerImageController {
    
        static func getPlayerImage(by searchTerm: String, completion: @escaping ((UIImage?) -> Void)) {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "www.haloapi.com"
            urlComponents.path = "/profile/h5/profiles/" + searchTerm + "/spartan"
            
            guard let url = urlComponents.url else { completion(nil) ; return }
                        
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue(apiKey1, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
    
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
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
