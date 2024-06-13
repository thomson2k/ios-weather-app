//
//  DailyForecast+CoreDataProperties.swift
//  ios-weather-app-final
//
//  Created by Tomasz Watroba on 13/06/2024.
//
//

import Foundation
import CoreData


extension DailyForecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyForecast> {
        return NSFetchRequest<DailyForecast>(entityName: "DailyForecast")
    }

    @NSManaged public var date: String?
    @NSManaged public var temperature: Double
    @NSManaged public var location: Location?

}

extension DailyForecast : Identifiable {

}
