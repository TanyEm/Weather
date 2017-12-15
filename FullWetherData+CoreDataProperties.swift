//
//  FullWetherData+CoreDataProperties.swift
//  
//
//  Created by Tanya Tomchuk on 15/11/2017.
//
//

import Foundation
import CoreData


extension FullWetherData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FullWetherData> {
        return NSFetchRequest<FullWetherData>(entityName: "FullWetherData")
    }

    @NSManaged public var main: NSObject?
    @NSManaged public var weather: NSObject?
    @NSManaged public var dt: Int64
    @NSManaged public var dt_txt: String?

}
