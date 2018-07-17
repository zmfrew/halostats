//
//  ViewController.swift
//  HaloStats
//
//  Created by Zachary Frew on 7/17/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        playerSearchBar.delegate = self
    }

    // MARK: - Outlets
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerGamerTag: UILabel!
    @IBOutlet weak var playerRank: UILabel!
    @IBOutlet weak var playerKills: UILabel!
    @IBOutlet weak var playerDeaths: UILabel!
    @IBOutlet weak var playerSearchBar: UISearchBar!
    
    // MARK: - Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            self.playerSearchBar.text = ""
            return
        }
        
        PlayerController.searchForPlayer(by: searchText) { (player) in
            guard let player = player else { return }
            
            DispatchQueue.main.async {
                self.playerSearchBar.text = ""
                self.playerGamerTag.text = player.gamertag
                self.playerRank.text = "\(player.rank)"
                self.playerKills.text = "\(player.kills)"
                self.playerDeaths.text = "\(player.deaths)"
            }
        }
    }
    
}

