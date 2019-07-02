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
    
    func searchPlayers(key: String) -> [Player]? {
        let request: NSFetchRequest<Player> = Player.fetchRequest()
        if key != "" {
            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@" , key)
        }
        let context = DataController.shared.persistentContainer.viewContext
        let players = try? context.fetch(request)
        return players
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
