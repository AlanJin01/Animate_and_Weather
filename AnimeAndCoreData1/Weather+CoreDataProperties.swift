//
//  Weather+CoreDataProperties.swift
//  AnimeAndCoreData1
//
//  Created by J K on 2019/1/5.
//  Copyright © 2019 Kims. All rights reserved.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var city: String?
    @NSManaged public var temp: String?
    @NSManaged public var weather: String?

}
