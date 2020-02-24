//
//  DataFetcherService.swift
//  swift-starter-kit
//
//  Created by Максим Спиридонов on 18.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation
class DataFetcherService {
    var dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    
    func fetchRSSAppleMusic(completion: @escaping (RSSModel?) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/apple-music/hot-tracks/all/20/explicit.json"
        dataFetcher.fetchGenericJSONData(urlString: urlString, response: completion)
    }
    
    
}
