//
//  AppDelegate.swift
//  swift-starter-kit
//
//  Created by Максим Спиридонов on 18.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var bgSessionCompletionHandler: (() -> ())?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        
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

