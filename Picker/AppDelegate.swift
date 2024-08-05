//
//  AppDelegate.swift
//  Picker
//
//  Created by Ruzanna on 04.08.24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    AppCoordinator.default.start()
    
    return true
  }
}
