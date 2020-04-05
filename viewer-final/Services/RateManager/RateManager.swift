//
//  RateManager.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 05.04.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation
import StoreKit


@available(iOS 10.3, *)
class RateManager {
    class func incrementCount() {
        let count = UserDefaults.standard.integer(forKey: "run_count")
        UserDefaults.standard.set(count + 1, forKey: "run_count")
        UserDefaults.standard.synchronize()
    }
    
    class func showRatesController() {
        let count = UserDefaults.standard.integer(forKey: "run_count")
        print("\(count) |  \(count % 5 == 0)")
        if count % 5 == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                SKStoreReviewController.requestReview()
            }
        }
    }
}
