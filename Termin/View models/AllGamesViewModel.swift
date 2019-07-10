//
//  AllGamesViewModel.swift
//  Termin
//
//  Created by FIVE on 10/07/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import Foundation

class AllGamesViewModel {
    
    var games : [Game]?
    
    func fetchGames(completion: @escaping() -> Void) {
        self.games = DataController.shared.fetchGames()
        completion()
    }
    
    func numberOfRows() -> Int {
        if let numGames = games?.count {
            return numGames
        }
        else {
            return 0
        }
    }
    
    func gamesCellData(atIndexPath indexPath: IndexPath) -> GamesCellData? {
        guard let games = self.games else {
            return nil
        }
        let game = games[indexPath.row]
        return GamesCellData(date: dateToString(date: game.date as Date), result: "\(game.team1Result) - \(game.team2Result) ")
    }
    
    private func dateToString(date : Date) -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: date) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        return myStringafd
    }
}
