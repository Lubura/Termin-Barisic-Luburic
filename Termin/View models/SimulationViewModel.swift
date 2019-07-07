//
//  SimulationViewModel.swift
//  Termin
//
//  Created by Marko Barisic on 06/07/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import Foundation
import UIKit

class SimulationViewModel {
    
    struct Section {
        var items: [Player]
        var team: String
        
        init(team: String) {
            self.team = team
            self.items = []
        }
    }
    
    private var items: [Player]? = nil
    private var sections: [Section] = []
    var team1: [Player]!
    var team2: [Player]!
    
    convenience init(players: [Player], team1: [Player], team2: [Player]) {
        self.init()
        self.items = players
        self.team1 = team1
        self.team2 = team2
        self.createSections()
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return sections[section].items.count
    }

    func numberOfSections() -> Int {
        return sections.count
    }

    func simulationCellData(atIndexPath indexPath: IndexPath) -> SimulationCellData? {
        guard items != nil else {
            return nil
        }
        let player = sections[indexPath.section].items[indexPath.row]
        return SimulationCellData(name: player.name)
    }

    func simulationHeaderData(forSection section: Int) -> SimulationHeaderData? {
        guard items != nil else {
            return nil
        }
        return SimulationHeaderData(title: "Team "+String(section+1), backgroundColor: UIColor.orange)
    }
    
    func playerViewModel(forIndexPath indexPath: IndexPath) -> PlayerViewModel {
        return PlayerViewModel(player: sections[indexPath.section].items[indexPath.row])
    }

    private func createSections() {
        sections.removeAll()
        self.sections.append(Section(team: "Team 1"))
        self.sections.append(Section(team: "Team 2"))
        
        items?.forEach { (player) in
            if team1.contains(player) {
                self.sections[0].items.append(player)
            } else if team2.contains(player) {
                self.sections[1].items.append(player)
            }
        }
    }
    
}
