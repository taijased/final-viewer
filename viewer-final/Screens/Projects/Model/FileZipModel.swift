//
//  FileZipModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 02.04.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation



struct FileZipModel {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init?(filePath: URL, forKey key: String) {
        self.key = key
        self.mimeType = "application/octet-stream"
//        self.mimeType = "application/zip"
        self.filename = filePath.lastPathComponent
        guard let data = try? Data(contentsOf: filePath) else { return nil }
        self.data = data
    }
}
