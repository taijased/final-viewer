//
//  FileManagerNotify.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 18.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation

enum FileManagerNotify {
    case fileExist
    case success
    case error
    func getDescription() -> String {
        switch self {
        case .fileExist:
            return "FileManager.exist".localized
        case .success:
            return "FileManager.success".localized
        case .error:
            return "FileManager.error".localized
        }
    }
}



