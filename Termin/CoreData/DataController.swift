//
//  DataController.swift
//  Termin
//
//  Created by Marko Barisic on 30/06/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import Foundation
import CoreData


class DataController {
    
    static let shared = DataController()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Termin")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchPlayers() -> [Player]? {
        
        let request: NSFetchRequest<Player> = Player.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let context = DataController.shared.persistentContainer.viewContext
        let players = try? context.fetch(request)
        return players
    }
    
    func fetchGames() -> [Game]? {
        let request: NSFetchRequest<Game> = Game.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let context = DataController.shared.persistentContainer.viewContext
       
        let games = try? context.fetch(request)
        return games
       
    }
    
    func searchGames(key: Int) -> [Game]? {
        let request: NSFetchRequest<Game> = Game.fetchRequest()
        if key <= 0{
            request.predicate = NSPredicate(format: "id CONTAINS[cd] %@" , key)
        }
        let context = DataController.shared.persistentContainer.viewContext
        let game = try? context.fetch(request)
        return game
    }
    
    func deleteGame(key: Int) -> String{
        if let game: Game = self.searchGames(key: key)?.first {
            persistentContainer.viewContext.delete(game)
            self.saveContext()
            return "Deleted"
        }
        return "Not deleted"
    }
    
    func viewGameDetails(key: Int) -> [String:Any]? {
        if let game: Game = self.searchGames(key: key)?.first {
            let output: [String:Any] = ["id":game.id, "date":game.date, "goalMinute":game.goalMinute,
                                        "team1":game.team1, "team2":game.team2, "team1Result":game.team1Result,
                                        "team2Result":game.team2Result]
            return output
        }
        return nil
    }
    
    func searchPlayers(key: String) -> [Player]? {
        let request: NSFetchRequest<Player> = Player.fetchRequest()
        if key != "" {
            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@" , key)
        }
        let context = DataController.shared.persistentContainer.viewContext
        let players = try? context.fetch(request)
        return players
    }
    
    func updatePlayerGoals(key: String, goals: Int) -> Bool {
        if let player: Player = self.searchPlayers(key: key)?.first {
            player.goals+=goals
            player.games+=1
            player.avgGoals = Float(player.goals)/Float(player.games)
            self.saveContext()
            return true
        }
        return false
    }
    
    func viewPlayerDetails(key: String) -> [String:Any]? {
        if let player: Player = self.searchPlayers(key: key)?.first {
            let output: [String:Any] = ["name": player.name, "rating": player.rating, "goals": player.goals, "games":player.games,"avgGoals":player.avgGoals]
            return output
        }
        return nil
    }
    
    func deletePlayer(key: String) -> String{
        if let player: Player = self.searchPlayers(key: key)?.first {
            persistentContainer.viewContext.delete(player)
            self.saveContext()
            return "Deleted"
        }
        return "Not deleted"
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
