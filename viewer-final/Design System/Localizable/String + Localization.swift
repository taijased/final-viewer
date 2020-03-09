//
//  String + Localization.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 06.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation



extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
