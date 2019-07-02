//
//  Game+CoreDataProperties.swift
//  
//
//  Created by FIVE on 02/07/2019.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var id: Int64
    @NSManaged public var goalMinute: [Player: Int]
    @NSManaged public var team1: [Player]
    @NSManaged public var team2: [Player]
    @NSManaged public var team1Result: Int64
    @NSManaged public var team2Result: Int64

}
