//
//  AspirationEntity+CoreDataProperties.swift
//  Climb Up
//
//  Created by Bohdan on 18.11.2020.
//
//

import Foundation
import CoreData


extension AspirationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AspirationEntity> {
        return NSFetchRequest<AspirationEntity>(entityName: "AspirationEntity")
    }

    @NSManaged public var colorHexStr: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var climb: NSSet?

}

// MARK: Generated accessors for climb
extension AspirationEntity {

    @objc(addClimbObject:)
    @NSManaged public func addToClimb(_ value: ClimbEntity)

    @objc(removeClimbObject:)
    @NSManaged public func removeFromClimb(_ value: ClimbEntity)

    @objc(addClimb:)
    @NSManaged public func addToClimb(_ values: NSSet)

    @objc(removeClimb:)
    @NSManaged public func removeFromClimb(_ values: NSSet)

}

extension AspirationEntity : Identifiable {

}
