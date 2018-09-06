//
//  AppDelegate.swift
//  Coinmarketcap Test
//
//  Created by Roman Slysh on 9/5/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let initialController = UINavigationController()
        initialController.setViewControllers([TableWireframe().viewController], animated: true)

        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.window?.rootViewController = initialController
        self.window?.makeKeyAndVisible()

        return true
    }
}
