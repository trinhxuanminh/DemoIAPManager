//
//  AppDelegate.swift
//  DemoIAP
//
//  Created by Trịnh Xuân Minh on 13/11/2024.
//

import UIKit
import IAPManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    IAPManager.shared.initialize(permissions: AppPermission.allCases)
    ProductManager.shared.fetch()
    verify()
    
    return true
  }
}

extension AppDelegate {
  private func verify() {
    Task {
      do {
        let permissions = try await IAPManager.shared.verify()
        PermissionManager.shared.unlock(permissions: permissions)
      } catch let error {
        print("Verify:", error)
      }
    }
  }
}
