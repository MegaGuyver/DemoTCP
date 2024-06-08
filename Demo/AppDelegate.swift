//
//  AppDelegate.swift
//  Demo
//
//  Created by khawaja fahad on 07/06/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setUpWindow()
        setRootViewController()

        return true
    }
}

// MARK: - AppDelegate Helpers
extension AppDelegate {
    
    func setUpWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
    }
    
    func setRootViewController() {
         window?.rootViewController = UINavigationController(rootViewController: TasksViewController())
    }
    
}

