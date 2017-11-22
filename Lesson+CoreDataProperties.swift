//
//  Lesson+CoreDataProperties.swift
//  MySchedule
//
//  Created by Jan-Hermen Dannenberg on 22/11/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//
//

import Foundation
import CoreData


extension Lesson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lesson> {
        return NSFetchRequest<Lesson>(entityName: "Lesson")
    }

    @NSManaged public var change: String?
    @NSManaged public var changeDescription: String?
    @NSManaged public var date: String?
    @NSManaged public var dayNumber: String?
    @NSManaged public var hour: String?
    @NSManaged public var location: String?
    @NSManaged public var remarks: String?
    @NSManaged public var subject: String?
    @NSManaged public var teacher: String?
    @NSManaged public var time: String?
    @NSManaged public var weekNumber: String?

}
