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
    let gamertag: String
    let kills: Int
    let deaths: Int
    let rank: Int
    let playerImage: PlayerImage
    
    enum CodingKeys: String, CodingKey {
        case gamertag = "Id"
        case kills = "TotalKills"
        case deaths = "TotalDeaths"
        case rank = "Rank"
        case playerImage
    }
    
}

// https://www.haloapi.com/stats/h5/servicerecords/arena?players=

struct PlayerImage: Codable {
    
    // MARK: - Properties
    let spartanImageURLAsString: String
    
    enum CodingKeys: String, CodingKey {
        case spartanImageURLAsString = "https://www.haloapi.com/profile/h5/profiles/"
    }
    
}

// https://www.haloapi.com/profile/h5/profiles/{player}/spartan[?size][&crop]
// crop is 'full' or 'portrait'
