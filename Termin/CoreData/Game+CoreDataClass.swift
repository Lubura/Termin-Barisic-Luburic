//
//  Game+CoreDataClass.swift
//  Termin
//
//  Created by Marko Barisic on 05/07/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//
//

import Foundation
import UIKit
import CoreData

@objc(Game)
public class Game: NSManagedObject {
    
    class func getEntityName() -> String{
        return "Game"
    }
    
    class func firstOrCreate(withId id: Int) -> Game?{
        let context = DataController.shared.persistentContainer.viewContext
        let request: NSFetchRequest<Game> = Game.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d" , id)
        request.returnsObjectsAsFaults = false
        
        do{
            let games = try context.fetch(request)
            if let game = games.first {
                return game
            } else {
                let newGame = Game(context: context)
                return newGame
            }
        } catch {
            return nil
        }
    }
    
    class func createFrom(json: [String: Any]) -> Game? {
        if
            let id = json["id"] as? Int,
            let date = json["date"] as? NSDate,
            let goalMinute = json["goalMinute"] as? [Player:[Int]],
            let team1 = json["team1"] as? [Player],
            let team2 = json["team2"] as? [Player],
            let team1Result = json["team1Result"] as? Int32,
            let team2Result = json["team2Result"] as? Int32{
            
            if let game = Game.firstOrCreate(withId: id){
                game.id = id
                game.date = date
                game.goalMinute = goalMinute
                game.team1 = team1
                game.team2 = team2
                game.team1Result = team1Result
                game.team2Result = team2Result
                
                do {
                    let context = DataController.shared.persistentContainer.viewContext
                    try context.save()
                    return game
                }
                catch {
                    print("Failed saving")
                }
            }
        }
        return nil
    }
    
}

