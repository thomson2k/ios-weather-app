//
//  Item+CoreDataProperties.swift
//  ios-weather-app-final
//
//  Created by Tomasz Watroba on 11/06/2024.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var timestamp: Date?

}

extension Item : Identifiable {

}
