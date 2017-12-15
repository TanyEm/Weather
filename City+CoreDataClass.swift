//
//  City+CoreDataClass.swift
//  
//
//  Created by Tanya Tomchuk on 22/11/2017.
//
//

import Foundation
import CoreData

@objc(City)
public class City: NSManagedObject {
    
    @NSManaged var cityName: String
    @NSManaged var tempCity: String

}
