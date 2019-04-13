//
//  EntityListTableViewController.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 13/04/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import CoreData
import UIKit

class EntityListTableViewController<T: NSManagedObject>: UITableViewController, CoreDataUsing, Attachable {
    var coreData: CoreDataService
    var observer: EntityObserver<T>!

    var onSelected: (T) -> Void = { _ in }

    required init(coreData: CoreDataService) {
        self.coreData = coreData
        super.init(nibName: nil, bundle: nil)
        loadViewIfNeeded()
        observer = EntityObserver(coreData: coreData)
        observer.observeFor(tableView: tableView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observer.getItems()
    }

    // MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return observer.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }

    // MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let model = observer[indexPath]
        if let model = model as? WorkoutSession {
        cell.textLabel?.text = model.sessionTypes?.first?.name ?? "Workout"
        cell.detailTextLabel?.text = "\(model.date)"
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelected(observer[indexPath])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
