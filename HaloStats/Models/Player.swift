//
//  Player.swift
//  HaloStats
//
//  Created by Zachary Frew on 7/17/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import Foundation

struct Player: Codable {
    
    // MARK: - Properties
    private let gamertagKey = "GamerTag"
    private let rankKey = "SpartanRank"
    
    let gamertag: String
    let rank: Int

    
    // MARK: - Initializers
    init?(playerDictionary: [String: Any]) {
        guard let gamertag = playerDictionary[gamertagKey] as? String, let rank = playerDictionary[rankKey] as? Int else { return nil }
        
        self.gamertag = gamertag
        self.rank = rank
    }
    
}



// https://www.haloapi.com/profile/h5/profiles/{player}/spartan[?size][&crop]
// crop is 'full' or 'portrait'
