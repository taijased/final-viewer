//
//  InformationModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 17.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation



enum InformationTableType {
    case ar
    case threeD
}

struct InformationCellType {
    var tableType: InformationTableType
    var informationIcons: InformationIcons?
    var label: String?
    
    init(icons: InformationIcons, type: InformationTableType) {
        self.informationIcons = icons
        self.tableType = type
    }
    
    init(label: String, type: InformationTableType) {
        self.label = label
        self.tableType = type
    }
}


enum InformationIcons {
    case move
    case moveUp
    case moveCamera
    case zoom
    case selected
    case rotation
    case logo
    
    func getImageLight() -> String {
        var result: String
        switch self {
        case .move:
            result = "move-light"
        case .moveUp:
            result = "moveUp-light"
        case .moveCamera:
            result = "moveCamera-light"
        case .zoom:
            result = "zoom-light"
        case .selected:
            result = "selected-light"
        case .rotation:
            result = "rotation-light"
        case .logo:
            result = "orbita-light"
        }
        return result
    }
    
    func getImageDark() -> String {
        var result: String
        switch self {
        case .move:
            result = "move-dark"
        case .moveUp:
            result = "moveUp-dark"
        case .moveCamera:
            result = "moveCamera-dark"
        case .zoom:
            result = "zoom-dark"
        case .selected:
            result = "selected-dark"
        case .rotation:
            result = "rotation-dark"
        case .logo:
            result = "orbita-dark"
        }
        return result
    }
    
    
    
    
    func getDescriptionType(_ tableType: InformationTableType) -> String {
        var result: String
        switch self {
        case .move:
            result = tableType == InformationTableType.ar ? "Info.ar.move".localized : "Info.3d.move".localized
        case .moveUp:
            result = "Info.moveUp".localized
        case .moveCamera:
            result = "Info.moveCamera".localized
        case .zoom:
            result = tableType == InformationTableType.ar ? "Info.ar.zoom".localized : "Info.3d.zoom".localized
        case .selected:
            result = "Info.selected".localized
        case .rotation:
            result = "Info.rotation".localized
        case .logo:
            result = "Info.logo".localized
        }
        return result
    }
}
