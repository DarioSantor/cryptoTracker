//
//  AppDelegate.swift
//  Crypto Tracker
//
//  Created by Santos, Dario Ferreira on 29/12/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        let navController = UINavigationController(rootViewController: CryptoTableViewController())
        window?.rootViewController = navController
        
        return true
    }


}

