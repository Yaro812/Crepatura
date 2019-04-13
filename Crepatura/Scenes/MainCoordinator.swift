//
//  MainCoordinator.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 14/04/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController = UINavigationController()

   var window: UIWindow = UIWindow()
    lazy var coreData = CoreDataService()

    func start() {
        let sessionsCoordinator = SessionsCoordinator(navigationController: navigationController, coreData: coreData)
        childCoordinators.append(sessionsCoordinator)
        sessionsCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func willTerminate() {
        coreData.saveContext()
    }

}
