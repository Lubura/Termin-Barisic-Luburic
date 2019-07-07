//
//  Player+CoreDataProperties.swift
//  Termin
//
//  Created by Marko Barisic on 05/07/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//
//

import Foundation
import CoreData


extension Player {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }
    
    @NSManaged public var name: String
    @NSManaged public var rating: Int32
    @NSManaged public var goals: Int
    @NSManaged public var games: Int
    @NSManaged public var avgGoals: Float
    
}

