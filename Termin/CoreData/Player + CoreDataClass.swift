//
//  Player + CoreDataClass.swift
//  Termin
//
//  Created by Marko Barisic on 30/06/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import Foundation
import CoreData

@objc(Player)
public class Player: NSManagedObject {
    
    class func getEntityName() -> String{
        return "Player"
    }
    
    class func firstOrCreate(withId name: String) -> Player? {
        let context = DataController.shared.persistentContainer.viewContext
        
        
        let request: NSFetchRequest<Player> = Player.fetchRequest()
        request.predicate = NSPredicate(format: "name = %d", name)
        request.returnsObjectsAsFaults = false
        
        do{
            let players = try context.fetch(request)
            if let player = players.first {
                return player
            } else {
                let newPlayer = Player(context: context)
                return newPlayer
            }
        } catch {
            return nil
        }
    }
    
    class func createFrom(json: [String: Any]) -> Player? {
        if
            let name = json["name"] as? String,
            let rating = json["rating"] as? Int {
            
            if let player = firstOrCreate(withId: name) {
                player.name = name
                player.rating = Int32(rating)
                do {
                    let context = DataController.shared.persistentContainer.viewContext
                    try context.save()
                    return player
                } catch {
                    print("Failed saving")
                }
            }
        }
        return nil
    }
    
}
