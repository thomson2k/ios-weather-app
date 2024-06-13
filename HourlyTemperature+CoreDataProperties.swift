//
//  HourlyTemperature+CoreDataProperties.swift
//  ios-weather-app-final
//
//  Created by Tomasz Watroba on 13/06/2024.
//
//

import Foundation
import CoreData


extension HourlyTemperature {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HourlyTemperature> {
        return NSFetchRequest<HourlyTemperature>(entityName: "HourlyTemperature")
    }

    @NSManaged public var temperature: Double
    @NSManaged public var time: String?
    @NSManaged public var location: Location?

}

extension HourlyTemperature : Identifiable {

}
