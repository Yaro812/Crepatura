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
        parent.present(vc, animated: true, completion: nil)
    }

    func workoutSessionAdded(sender: UIViewController) {
        sender.dismiss(animated: true, completion: nil)
    }

    func selected(workoutSession: WorkoutSession) {
        print("Workout session selected: \(workoutSession.id)")
    }
}
