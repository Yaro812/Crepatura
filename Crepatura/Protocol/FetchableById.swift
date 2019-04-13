//
//  FetchableById.swift
//  CD
//
//  Created by user on 06/03/2019.
//  Copyright © 2019 user. All rights reserved.
//

import CoreData
import Foundation

protocol FetchableById {
    associatedtype Id
}


extension FetchableById where Self: NSManagedObject, Id == UUID {
    static func fetch(id: Id, in context: NSManagedObjectContext) -> Self? {
        let request = NSFetchRequest<Self>(entityName: name)
        let predicate = NSPredicate(format: "id = %@", id.uuidString)
        request.predicate = predicate
        do {
            let items = try context.fetch(request)
            return items.first
        } catch {
            fatalError("Can't perform request \(request). Error: \(error)")
        }
    }
}

extension FetchableById where Self: NSManagedObject, Id: CVarArg {
    static func fetch(id: Id, in context: NSManagedObjectContext) -> Self? {
        let request = NSFetchRequest<Self>(entityName: name)
        let predicate = NSPredicate(format: "id = %@", id)
        request.predicate = predicate
        do {
            let items = try context.fetch(request)
            return items.first
        } catch {
            fatalError("Can't perform request \(request). Error: \(error)")
        }
    }
}

extension NSManagedObject {
    static var name: String { return "\(self)" }
}
