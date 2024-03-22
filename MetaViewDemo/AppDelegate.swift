//
//  AppDelegate.swift
//  MetaViewDemo
//
//  Created by teneocto on 01/03/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  lazy private(set) var coordinator = makeCoordinator()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    coordinator.start()
    return true
  }

  func makeCoordinator() -> AppCoordinator {
    if window == nil {
      window = UIWindow(frame: UIScreen.main.bounds)
    }
    let navigationController = UINavigationController()
    let coordinator = AppCoordinator(navigation: navigationController)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    return coordinator
  }
}

