//
//  City+CoreDataProperties.swift
//  
//
//  Created by Tanya Tomchuk on 22/11/2017.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var tempCity: String?
}
