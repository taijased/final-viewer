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
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.Primary.primary
        
        
        let viewController = SplashViewController()
        viewController.finishedSplashScreen = {
            let viewController = CloudViewController()
            viewController.modalTransitionStyle = .crossDissolve
            let navigationController = UINavigationController(rootViewController: viewController)
            self.window?.rootViewController = navigationController
        }
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        

        
        
        
        return true
    }
    
 
}

