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
        
        
        
//        if window?.traitCollection.userInterfaceStyle == .light {
//           
//             window?.backgroundColor = .black
//        } else {
//             window?.backgroundColor = .white
//        }
//        
        
        
        
        let viewController = SplashViewController()
        viewController.deinitViewController = { [weak self] in
            let viewController = ProjectsViewController()
            viewController.modalPresentationStyle = .fullScreen
            viewController.modalTransitionStyle = .crossDissolve
            let navigationController = UINavigationController(rootViewController: viewController)
            self?.window?.rootViewController = navigationController
        }
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
 
}

