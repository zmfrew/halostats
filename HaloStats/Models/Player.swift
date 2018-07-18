//
//  Player.swift
//  HaloStats
//
//  Created by Zachary Frew on 7/17/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import Foundation

class Player: Codable {
    
    // MARK: - Properties
    private let gamertagKey = "Id"
    private let rankKey = "SpartanRank"
    private let killsKey = "TotalKills"
    private let deathsKey = "TotalDeaths"
    
    let gamertag: String
    let rank: Int
    let kills: Int
    let deaths: Int
    
    // MARK: - Initializers
    init?(playerDictionary: [String : Any]) {
        guard let resultsArray = playerDictionary["Results"] as? [[String : Any]],
        let gamertag = resultsArray.first?[gamertagKey] as? String,
        let resultDictionary = resultsArray.first?["Result"] as? [String : Any],
        let rank = resultDictionary[rankKey] as? Int,
        let arenaStatsDictionary = resultDictionary["ArenaStats"] as? [String : Any],
        let kills = arenaStatsDictionary[killsKey] as? Int,
        let deaths = arenaStatsDictionary[deathsKey] as? Int
            else { return nil }
        
        self.gamertag = gamertag
        self.rank = rank
        self.kills = kills
        self.deaths = deaths
    }
    
}
