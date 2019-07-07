//
//  PickPlayersViewModel.swift
//  Termin
//
//  Created by Marko Barisic on 30/06/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import Foundation


class PickPlayersViewModel {
    
    var items: [Player]? = nil
    
    func fetchPlayers(completion: @escaping() -> Void) {
        self.items = DataController.shared.fetchPlayers()
        completion()
    }
    
    func searchQuizList(name: String) {
        self.items = DataController.shared.searchPlayers(key: name)
    }
    
    func numberOfRows() -> Int {
        if let numItems = items?.count {
            return numItems
        }
        else {
            return 0
        }
    }
    
    func pickPlayersCellData(atIndexPath indexPath: IndexPath) -> PickPlayersCellData? {
        guard items != nil else {
            return nil
        }
        let player = items![indexPath.row]
        return PickPlayersCellData(name: player.name)
    }
    
    func playerViewModel(forIndexPath indexPath: IndexPath) -> PlayerViewModel {
        return PlayerViewModel(player: items![indexPath.row])
    }
}
