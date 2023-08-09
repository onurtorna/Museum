//
//  AppDelegate.swift
//  Museum
//
//  Created by Onur Torna on 07.08.2023.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MuseumItemsListBuilder.build()
        window?.makeKeyAndVisible()
        return true
    }
}
