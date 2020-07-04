//
//  RoomsData+CoreDataProperties.swift
//  kpiRozkladSwiftUI
//
//  Created by Денис Данилюк on 28.06.2020.
//
//

import Foundation
import CoreData


extension RoomsData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoomsData> {
        return NSFetchRequest<RoomsData>(entityName: "RoomsData")
    }

    @NSManaged public var roomID: Int32
    @NSManaged public var roomLatitude: String?
    @NSManaged public var roomLongitude: String?
    @NSManaged public var roomName: String?
    @NSManaged public var roomsRelationship: LessonData?

    
    public var wrappedRoom: Room {
        Room(roomID: Int(roomID), roomName: roomName ?? "", roomLatitude: roomLatitude ?? "", roomLongitude: roomLongitude ?? "")
    }
}
