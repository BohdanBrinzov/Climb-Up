//
//  ClimbEntity+CoreDataProperties.swift
//  Climb Up
//
//  Created by Bohdan on 18.11.2020.
//
//

import Foundation
import CoreData


extension ClimbEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClimbEntity> {
        return NSFetchRequest<ClimbEntity>(entityName: "ClimbEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var quality: Int16
    @NSManaged public var timeActive: Double
    @NSManaged public var timeAll: Double
    @NSManaged public var timeInterval: Double
    @NSManaged public var timeRest: Double
    @NSManaged public var aspiration: AspirationEntity?

}

extension ClimbEntity : Identifiable {

}
