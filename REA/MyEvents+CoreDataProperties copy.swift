//
//  MyEvents+CoreDataProperties.swift
//  
//
//  Created by MSS on 30/01/21.
//
//

import Foundation
import CoreData


extension MyEvents {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyEvents> {
        return NSFetchRequest<MyEvents>(entityName: "MyEvent")
    }

    @NSManaged public var eventEnd: Date?
    @NSManaged public var eventStart: Date?
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?

}
