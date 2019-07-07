//
//  Game+CoreDataProperties.swift
//  Termin
//
//  Created by Marko Barisic on 05/07/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//
//

import Foundation
import CoreData


extension Game {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }
    
    @NSManaged public var id: Int
    @NSManaged public var date: NSDate
    @NSManaged public var goalMinute: [Player: [Int]]
    @NSManaged public var team1: [Player]
    @NSManaged public var team2: [Player]
    @NSManaged public var team1Result: Int32
    @NSManaged public var team2Result: Int32
}

