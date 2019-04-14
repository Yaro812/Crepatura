//
//  SessionsCoordinator.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 14/04/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import UIKit

class SessionsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController
    let coreData: CoreDataService

    init(navigationController: UINavigationController, coreData: CoreDataService) {
        self.navigationController = navigationController
        self.coreData = coreData
    }

    func start() {
        let vc = WorkoutSessionsVC(coordinator: self, coreData: coreData)
        navigationController.pushViewController(vc, animated: false)
    }

    func addWorkoutSession(from parent: UIViewController) {
        let vc = AddWorkoutSessionVC(coordinator: self, coreData: coreData)
        navigationController.pushViewController(vc, animated: true)
    }

    func workoutSessionAdded(sender: UIViewController) {
        navigationController.popViewController(animated: true)
    }

    func selected(workoutSession: WorkoutSession) {
        print("Workout session selected: \(workoutSession.id)")
    }

    func listSessionTypes() {
        let vc = EntityListTableViewController<SessionType>(coreData: coreData, sortDescriptor: NSSortDescriptor(key: "name", ascending: true))
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func addEntityRequested(from viewController: UIViewController) {
        print("add tapped from \(viewController)")
        if viewController is EntityListTableViewController<SessionType> {
            let vc = AddSessionTypeViewController(coordinator: self, coreData: coreData)
            navigationController.pushViewController(vc, animated: true)
        }
    }

    func sessionTypeAdded(sender: UIViewController) {
        navigationController.popViewController(animated: true)
    }
}
