//
//  GameViewModel.swift
//  Termin
//
//  Created by Marko Barisic on 05/07/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import Foundation

class GameViewModel {
    private var game: Game
    private var team1: [Player]
    private var team2: [Player]
    
    init(game: Game){
        self.game = game
        self.team1 = game.team1
        self.team2 = game.team2
    }
    
    var id: Int {
        return game.id
    }
    
    var date: NSDate {
        return game.date
    }
    
    var goalMinute: [Player:[Int]] {
        return game.goalMinute
    }
    
    var team1Result: Int32 {
        return game.team1Result
    }
    
    var team2Result: Int32 {
        return game.team2Result
    }
    
    func playerViewModel(forIndex index: Int, inTeam team:Int) -> PlayerViewModel?{
        if team == 1{
            return PlayerViewModel(player: team1[index])}
        else if team == 2{
            return PlayerViewModel(player: team2[index])
        }
        return nil
    }
    
    
}
