//
//  PlayerViewModel.swift
//  Termin
//
//  Created by Marko Barisic on 05/07/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import Foundation

class PlayerViewModel {
    var player: Player
    
    init(player: Player) {
        self.player = player
    }
    
    var name: String {
        return player.name
    }
    
    var rating: Int32 {
        return player.rating
    }
    
    var goals: Int {
        return player.goals
    }
    
    var games: Int {
        return player.games
    }
    
    var avgGoals: Float {
        return player.avgGoals
    }
}
