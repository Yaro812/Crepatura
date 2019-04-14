//
//  EntityListViewController.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 13/04/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import CoreData
import UIKit

class EntityObserver<T: NSManagedObject>: NSObject {
    var count: Int { return fetchController.fetchedObjects?.count ?? 0 }
    
    private var coreData: CoreDataService!
    private var manager: EntityObserverManager?

    private var sortDescriptor: NSSortDescriptor?

       private lazy var fetchController: NSFetchedResultsController<T> = {
            let context = coreData.viewContext
            let sortDescriptor = self.sortDescriptor ?? NSSortDescriptor(key: "date", ascending: false)
            let request = NSFetchRequest<T>(entityName: "\(T.self)")
            request.sortDescriptors = [sortDescriptor]
            let controller = NSFetchedResultsController(fetchRequest: request,
                                                        managedObjectContext: context,
                                                        sectionNameKeyPath: nil,
                                                        cacheName: nil)
            return controller
        }()

    init(coreData: CoreDataService, sortDescriptor: NSSortDescriptor? = nil) {
        self.coreData = coreData
        self.sortDescriptor = sortDescriptor
    }

    func getItems() {
        do {
            try fetchController.performFetch()
        } catch {
            print(error)
        }
    }

    func observeFor(tableView: UITableView) {
        let manager = TableViewEntityManager(tableView: tableView)
        fetchController.delegate = manager
        self.manager = manager
    }

    subscript(indexPath: IndexPath) -> T {
        return fetchController.object(at: indexPath)
    }
}


