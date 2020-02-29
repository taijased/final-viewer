//
//  CustomAlertAction.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 28.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit



enum CustomAlertAction {
    case open
    case rename
    case share
    case delete
    case cancel
    
    func getIconName() -> String {
        var result: String
        switch self {
        case .open:
            result = "open-as"
        case .rename:
            result = "rename-as"
        case .share:
            result = "share-as"
        case .delete:
            result = "delete-as"
        case .cancel:
            result = ""
        }
        return result
    }
    
    func getTitleName() -> String {
        var result: String
        switch self {
        case .open:
            result = "Open"
        case .rename:
            result = "Rename"
        case .share:
            result = "Share"
        case .delete:
            result = "Delete file"
        case .cancel:
            result = "Cancel"
        }
        return result
    }
    
    func getStyle() -> UIAlertAction.Style {
        
        let result: UIAlertAction.Style = {
            switch self {
            case .open:
                return .default
            case .rename:
                return .default
            case .share:
                return .default
            case .delete:
                return .destructive
            case .cancel:
                return .cancel
            }
        }()
        
        return result
    }
}




