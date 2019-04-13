//
//  AppDelegate.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 07/03/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var coordinator: MainCoordinator = MainCoordinator()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = coordinator.window
        coordinator.start()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
       coordinator.willTerminate()
    }

}

