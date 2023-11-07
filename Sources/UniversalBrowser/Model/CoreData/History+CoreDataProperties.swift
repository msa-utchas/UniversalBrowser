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

    @NSManaged public var url: String?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?

}
