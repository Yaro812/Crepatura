//
//  WorkoutsVC.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 07/03/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import CoreData
import UIKit

final class WorkoutSessionsVC: UIViewController, CoreDataUsing {
    let coordinator: SessionsCoordinator
    let coreData: CoreDataService

    let sessionsViewController: EntityListTableViewController<WorkoutSession>

    var observer: EntityObserver<WorkoutSession>!

    required init(coordinator: SessionsCoordinator, coreData: CoreDataService) {
        self.coordinator = coordinator
        self.coreData = coreData
        sessionsViewController = EntityListTableViewController<WorkoutSession>(coreData: coreData)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItem()
        setupView()
    }

    func setupNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete All",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(tapRemoveAll))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(tapAdd))
    }

    func setupView() {
        sessionsViewController.attach(to: self, in: view)
        sessionsViewController.onSelected = { [weak self] workoutSession in
            self?.coordinator.selected(workoutSession: workoutSession)
        }
    }

    @objc
   func tapAdd(_ sender: UIBarButtonItem) {
        print("add")
        coordinator.addWorkoutSession(from: self)
    }

    @objc
    func tapRemoveAll(_ sender: Any) {
        print("clear all WorkoutSessions")
        coreData.removeAll(WorkoutSession.self)
    }
}
