//
//  AppDelegate.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 19/01/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
             let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
             let compareVC = mainStoryBoard.instantiateViewController(withIdentifier: "CompareViewController")
             self.window?.rootViewController = compareVC
             self.window?.makeKeyAndVisible()
             return true
    }
}

