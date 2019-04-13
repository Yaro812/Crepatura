//
//  WorkoutsVC.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 07/03/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import CoreData
import UIKit

class WorkoutSessionsVC: UIViewController, CoreDataUsing {
    var coreData: CoreDataService!
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!

    var observer: EntityObserver<WorkoutSession>!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let coreData = (UIApplication.shared.delegate as? AppDelegate)?.coreData else {
            fatalError("couldn't access Core Data service")
        }

        self.coreData = coreData

        observer = EntityObserver<WorkoutSession>(coreData: coreData)
        observer.observeFor(tableView: tableView)

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observer.getItems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddWorkoutSessionVC {
            vc.coreData = coreData
        }
    }

    @IBAction func tapAdd(_ sender: UIBarButtonItem) {
        print("add")
        performSegue(withIdentifier: "toAddWorkout", sender: self)
    }

    @IBAction func tapRemoveAll(_ sender: Any) {
        print("clear all WorkoutSessions")
        coreData.removeAll(WorkoutSession.self)
    }
}

extension WorkoutSessionsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return observer.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}

extension WorkoutSessionsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let model = observer[indexPath]
        cell.textLabel?.text = model.sessionType?.name ?? "Workout"
        cell.detailTextLabel?.text = "\(model.date)"
    }
}
