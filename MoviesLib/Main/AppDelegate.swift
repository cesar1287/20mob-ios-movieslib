//
//  AppDelegate.swift
//  MoviesLib
//
//  Created by Cesar Nascimento on 22/09/20.
//  Copyright © 2020 Cesar Nascimento. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.tintColor = UIColor(named: "Main")
        
        // Override point for customization after application launch.
        return true
    }

}
