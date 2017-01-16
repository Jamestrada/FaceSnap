//
//  Location.swift
//  FaceSnap
//
//  Created by James Estrada on 12/01/2017.
//  Copyright © 2017 James Estrada. All rights reserved.
//

import Foundation
import CoreData

class Location: NSManagedObject {
    static let entityName = "\(Location.self)"
    
    class func locationWith(latitude: Double, longitude: Double) -> Location {
        let location = NSEntityDescription.insertNewObjectForEntityForName(Location.entityName, inManagedObjectContext: CoreDataController.sharedInstance.managedObjectContext) as! Location
        
        location.latitude = latitude
        location.longitude = longitude
        
        return location
    }
}

extension Location {
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
}