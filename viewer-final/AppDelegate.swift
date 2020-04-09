//
//  AppDelegate.swift
//  swift-starter-kit
//
//  Created by Максим Спиридонов on 18.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var bgSessionCompletionHandler: (() -> ())?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,

            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })

        Realm.Configuration.defaultConfiguration = config

        
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        RateManager.incrementCount()
        
        //        let viewController = TestViewController()
        
        let viewController = SplashViewController()
        
        viewController.deinitViewController = { [weak self] in
            let viewController = ProjectsViewController(guid: nil)
            viewController.modalPresentationStyle = .fullScreen
            viewController.modalTransitionStyle = .crossDissolve
            let navigationController = UINavigationController(rootViewController: viewController)
            self?.window?.rootViewController = navigationController
        }
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        
        
        
        
        return true
    }
    
    
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb, let url = userActivity.webpageURL else { return false }
        
     
        let viewController = SplashViewController()
        
        viewController.deinitViewController = { [weak self] in
            let viewController = ProjectsViewController(guid: url.lastPathComponent)
            viewController.modalPresentationStyle = .fullScreen
            viewController.modalTransitionStyle = .crossDissolve
            let navigationController = UINavigationController(rootViewController: viewController)
            self?.window?.rootViewController = navigationController
        }
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    
    
    
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        bgSessionCompletionHandler = completionHandler
    }
    
}

