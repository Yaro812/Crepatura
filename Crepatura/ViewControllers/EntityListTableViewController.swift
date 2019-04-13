//
//  EntityListTableViewController.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 13/04/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import CoreData
import UIKit

class EntityListTableViewController<T: NSManagedObject>: UITableViewController, CoreDataUsing {
    static func create<T: NSManagedObject>(for type:T.Type, with coreData: CoreDataService) -> EntityListTableViewController<T> {
        let vc = EntityListTableViewController<T>()
        vc.loadViewIfNeeded()
        vc.register(coreData: coreData)
        return vc
    }

    var coreData: CoreDataService!
    var observer: EntityObserver<T>!

    func register(coreData: CoreDataService) {
        self.coreData = coreData
        observer = EntityObserver(coreData: coreData)
        observer.observeFor(tableView: tableView)
    }

    // MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return observer.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
