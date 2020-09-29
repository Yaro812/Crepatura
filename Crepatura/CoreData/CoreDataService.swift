//
//  CoreDataService.swift
//  CD
//
//  Created by user on 06/03/2019.
//  Copyright © 2019 user. All rights reserved.
//

import Dispatch
import Foundation
import CoreData

class CoreDataService {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Entities")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext { return persistentContainer.viewContext }

    init() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(updatedCoreData),
                                       name: .NSManagedObjectContextDidSave, object: nil)
    }

    func performInBackground(block: @escaping (NSManagedObjectContext) -> Void) {
        self.persistentContainer.performBackgroundTask(block)
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<Item: NSManagedObject>(predicate: NSPredicate? = nil) -> [Item] {
        let request = NSFetchRequest<Item>(entityName: "\(Item.self)")
        request.predicate = predicate
        do {
            let items = try persistentContainer.viewContext.fetch(request)
            return items
        } catch {
            fatalError("Can't perform request \(request). Error: \(error)")
        }
    }

    func removeAll<T: NSManagedObject>(_ type: T.Type) {
        performInBackground { context in
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: T.name)

            do {
                if let items = try context.fetch(request) as? [NSManagedObject] {
                    for item in items {
                        context.delete(item)
                    }
                    try context.save()
                }
            } catch {
                print("Error occured: \(error)")
            }
        }
    }

    @objc
    private func updatedCoreData(_ notification: Notification){
        if let inserted = notification.userInfo?[NSInsertedObjectsKey] as? Set<NSManagedObject>, inserted.count > 0 {
            print("Inserted count: \(inserted.count)")
        }
        if let updated = notification.userInfo?[NSUpdatedObjectsKey] as? Set<NSManagedObject>, updated.count > 0 {
            print("Updated count: \(updated.count)")
        }
        if let deleted = notification.userInfo?[NSDeletedObjectsKey] as? Set<NSManagedObject>, deleted.count > 0 {
            print("Deleted count: \(deleted.count)")
        }

        DispatchQueue.main.async {
            self.viewContext.mergeChanges(fromContextDidSave: notification)
        }
    }

}
