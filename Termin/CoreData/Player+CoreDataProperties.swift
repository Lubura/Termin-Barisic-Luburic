//
//  Player+CoreDataProperties.swift
//  
//
//  Created by FIVE on 02/07/2019.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var name: String?
    @NSManaged public var rating: Int32
    @NSManaged public var goals: Int64
    @NSManaged public var avgGoals: Float
    @NSManaged public var nmbrOfGames: Int64
    


}
