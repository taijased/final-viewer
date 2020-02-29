//
//  SelectCloudModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation

struct SelectCloudModel {
    var label: String
    var iconName: String
    var type: CloudModel
    init(type: CloudModel) {
        self.type = type
        self.iconName = type.getIconName()
        self.label = type.getLabel()
    }
}



enum SelectCloudNavigation {
    case supportedFormats
    case documentPicker
    case errorFormat(msg: String)
    case dismiss
}


