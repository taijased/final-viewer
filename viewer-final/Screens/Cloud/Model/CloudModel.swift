//
//  CloudModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 25.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation


enum CloudModel {
    case googledisk
    case dropboxs
    case yadisk
    case onedrive
    case icloud
    case systemFiles
    func getLabel() -> String {
        switch self {
        case .googledisk:
            return "Google Drive"
        case .dropboxs:
            return "Dropbox"
        case .yadisk:
            return "Yandex.Disk"
        case .onedrive:
            return "OneDrive"
        case .icloud:
            return "iCloud"
        case .systemFiles:
            return  "Choose from file"
        }
    }
    
    func getIconName() -> String {
        switch self {
        case .googledisk:
            return "gd-logo"
        case .dropboxs:
            return "db-logo"
        case .yadisk:
            return "yd-logo"
        case .onedrive:
            return "od-logo"
        case .icloud:
            return "i-logo"
        case .systemFiles:
            return "files-logo"
        }
    }
}


enum CloudNavigation {
    case selectCloud
    case dismiss
}
