//
//  Player + CoreDataProperties.swift
//  Termin
//
//  Created by Marko Barisic on 30/06/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import Foundation
import CoreData

extension Player {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player>{
        return NSFetchRequest<Player>(entityName: "Player")
    }
    
    @NSManaged public var name: String
    @NSManaged public var rating: Int32
    
}
