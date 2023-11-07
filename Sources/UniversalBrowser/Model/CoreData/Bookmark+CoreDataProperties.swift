//
//  Bookmark+CoreDataProperties.swift
//  UseUniversalBrowser
//
//  Created by BJIT on 7/11/23.
//
//

import Foundation
import CoreData


extension Bookmark {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmark> {
        return NSFetchRequest<Bookmark>(entityName: "Bookmark")
    }
    
    @nonobjc public class func fetchRequestDate() -> NSFetchRequest<Bookmark> {
        let request = NSFetchRequest<Bookmark>(entityName: "Bookmark")
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
        return request
    }

    @NSManaged public var link: String?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?

}

extension Bookmark : Identifiable {

}
