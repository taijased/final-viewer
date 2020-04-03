//
//  UploadingResponse.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 01.04.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation



struct UploadingResponse: Codable {
    let success: Bool
    let message, guid: String?
}


struct DownloadResponse: Codable {
    let data: Data
}
