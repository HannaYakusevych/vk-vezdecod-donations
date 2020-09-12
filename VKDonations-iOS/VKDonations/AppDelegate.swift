//
//  AppDelegate.swift
//  VKDonations
//
//  Created by Анна Якусевич on 11.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let donatesListViewController = DonatesListViewController()
        let rootNavigationController = UINavigationController(rootViewController: donatesListViewController)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        return true
    }
}

