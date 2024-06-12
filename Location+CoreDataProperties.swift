//
//  Location+CoreDataProperties.swift
//  ios-weather-app-final
//
//  Created by Tomasz Watroba on 11/06/2024.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var lng: Double
    @NSManaged public var lat: Double

}

extension Location : Identifiable {

}
