//
//  History+CoreDataProperties.swift
//  
//
//  Created by BJIT on 7/11/23.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @nonobjc public class func fetchRequestDate() -> NSFetchRequest<History> {
        let request = NSFetchRequest<History>(entityName: "History")
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
        return request
    }

    @NSManaged public var url: String?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?

}
