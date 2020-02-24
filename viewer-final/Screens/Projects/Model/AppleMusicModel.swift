//
//  AppleMusicModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 19.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation

struct RSSModel: Codable {
    var feed: Feed
}

struct Feed: Codable {
    var title: String
    var results: [AppleSong]
}


struct AppleSong: Codable {
    var id: String
    var name: String
    var artworkUrl100: String
    var url: String
}
