//
//  CoreDataManager.swift
//  UseUniversalBrowser
//
//  Created by BJIT on 7/11/23.
//



import Foundation
import CoreData

/*
 --- make unique attribute, and should have a notification if try to insert duplicate item
*/

public class CoredataManager {
    
    static let shared = CoredataManager()
    var context:NSManagedObjectContext?
    
    init() {
        self.context = persistentContainer?.viewContext
    }

    public func insertBookmark(url:String, title: String) {
        
        if isLinkAlreadyExist(url: url){
            return
        }
        
        let newBookmark = NSEntityDescription.insertNewObject(forEntityName: "Bookmark", into: context!) as! Bookmark
        newBookmark.url = url
        newBookmark.title = title
        newBookmark.date = Date()
        
        saveContext(errorText: "can't insert")
    }
    
    public func getAllBookmark() -> [Bookmark] {
        
        return try! context!.fetch(Bookmark.fetchRequest())
    }
    
    public func getAllBookmarkByDateSorted() -> [Bookmark] {
        
        return try! context!.fetch(Bookmark.fetchRequestDate())
    }
    
    public func deleteBookmark(bookmark: Bookmark) {
        
        context?.delete(bookmark)
        saveContext(errorText: "can't delete")
    }
    

    
    lazy private var persistentContainer: PersistentContainer? = {
        guard let modelURL = Bundle.module.url(forResource:"UniversalBrowser", withExtension: "momd") else { return  nil }  // momd, xcdatamodeld
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else { return nil }
        let container = PersistentContainer(name:"UniversalBrowser",managedObjectModel:model)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    private func saveContext(errorText: String){
        do {
            try context?.save()
        } catch {
            print(errorText)
        }
    }
    
    private func isLinkAlreadyExist(url:String)->Bool{
        let allBookmark = getAllBookmark()
        for bkmrk in allBookmark {
            if bkmrk.url == url {
                return true
            }
        }
        return false
    }
}
