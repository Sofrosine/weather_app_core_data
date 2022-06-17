//
//  WeatherEntities+CoreDataProperties.swift
//  weather-app
//
//  Created by Soultan Muhammad Albar on 17/06/22.
//
//

import Foundation
import CoreData


extension WeatherEntities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherEntities> {
        return NSFetchRequest<WeatherEntities>(entityName: "WeatherEntities")
    }

    @NSManaged public var cityName: String?

}

extension WeatherEntities : Identifiable {

}
