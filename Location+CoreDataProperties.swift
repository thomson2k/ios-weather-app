//
//  Location+CoreDataProperties.swift
//  ios-weather-app-final
//
//  Created by Tomasz Watroba on 13/06/2024.
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
    @NSManaged public var lastUpdatedDate: Date?
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var dailyForecasts: NSSet?
    @NSManaged public var hourlyTemperatures: NSSet?

}

// MARK: Generated accessors for dailyForecasts
extension Location {

    @objc(addDailyForecastsObject:)
    @NSManaged public func addToDailyForecasts(_ value: DailyForecast)

    @objc(removeDailyForecastsObject:)
    @NSManaged public func removeFromDailyForecasts(_ value: DailyForecast)

    @objc(addDailyForecasts:)
    @NSManaged public func addToDailyForecasts(_ values: NSSet)

    @objc(removeDailyForecasts:)
    @NSManaged public func removeFromDailyForecasts(_ values: NSSet)

}

// MARK: Generated accessors for hourlyTemperatures
extension Location {

    @objc(addHourlyTemperaturesObject:)
    @NSManaged public func addToHourlyTemperatures(_ value: HourlyTemperature)

    @objc(removeHourlyTemperaturesObject:)
    @NSManaged public func removeFromHourlyTemperatures(_ value: HourlyTemperature)

    @objc(addHourlyTemperatures:)
    @NSManaged public func addToHourlyTemperatures(_ values: NSSet)

    @objc(removeHourlyTemperatures:)
    @NSManaged public func removeFromHourlyTemperatures(_ values: NSSet)

}

extension Location : Identifiable {

}
