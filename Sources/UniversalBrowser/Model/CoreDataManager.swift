//
//  CoreDataManager.swift
//  UseUniversalBrowser
//
//  Created by BJIT on 7/11/23.
//



import Foundation
import CoreData

public class CoredataManager {
    
    static let shared = CoredataManager()
//    let context = appDelegate.persistentContainer.viewContext
    var context:NSManagedObjectContext?
    
    init() {
        self.context = persistentContainer?.viewContext
    }
    
    public func deleteBookmark(bookmark: Bookmark) {
        
        context?.delete(bookmark)
        saveContext(errorText: "can't delete")
    }
    

    public func fetchBookmark() -> [Bookmark] {
        
        return try! context!.fetch(Bookmark.fetchRequest())
    }
    
    public func fetchBookmarkByDate() -> [Bookmark] {
        
        return try! context!.fetch(Bookmark.fetchRequestDate())
    }

    public func insertBookmark(link:String, title: String) {
        
        if isLinkAlreadyExist(link: link){
            return
        }
        
        let newBookmark = NSEntityDescription.insertNewObject(forEntityName: "Bookmark", into: context!) as! Bookmark
        
        newBookmark.link = link
        newBookmark.title = title
        newBookmark.date = Date()
        
        saveContext(errorText: "can't insert")
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
    
    private func isLinkAlreadyExist(link:String)->Bool{
        let allBookmark = fetchBookmark()
        for bkmrk in allBookmark {
            if bkmrk.link == link {
                return true
            }
        }
        return false
    }
}
