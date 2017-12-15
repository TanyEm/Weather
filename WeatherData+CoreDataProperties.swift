//
//  WeatherData+CoreDataProperties.swift
//  
//
//  Created by Tanya Tomchuk on 15/11/2017.
//
//

import Foundation
import CoreData


extension WeatherData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherData> {
        return NSFetchRequest<WeatherData>(entityName: "WeatherData")
    }

    @NSManaged public var name: String?
    @NSManaged public var weather: NSObject?
    @NSManaged public var main: NSObject?

}
