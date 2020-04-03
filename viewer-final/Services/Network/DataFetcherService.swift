//
//  DataFetcherService.swift
//  swift-starter-kit
//
//  Created by Максим Спиридонов on 18.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation


class DataFetcherService {
    
    var onProgress: ((Double) -> ())?
    
    //    fileprivate let baseURL = "https://handshake.arq.su/vl/"
    fileprivate let baseURL = "http://192.168.0.113:5000/"
    
    
    
    var dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
        self.dataFetcher.onProgress = { [weak self] progress in
            self?.onProgress?(progress)
        }
    }
    
    
    //    func fetchRSSAppleMusic(completion: @escaping (RSSModel?) -> Void) {
    //        let urlString = "https://rss.itunes.apple.com/api/v1/us/apple-music/hot-tracks/all/20/explicit.json"
    //        dataFetcher.fetchGenericJSONData(urlString: urlString, response: completion)
    //    }
    
    
    func uploadFile(fileData: Data, completion: @escaping (UploadingResponse?) -> Void) {
        let urlString = baseURL + "share"
        dataFetcher.uploadGenericJSONData(urlString: urlString, data: fileData, response: completion)
    }
    
    func uploadFile(filePath: URL, completion: @escaping (UploadingResponse?) -> Void) {
        let urlString = baseURL + "share"
        dataFetcher.uploadGenericData(urlString: urlString, filePath: filePath, response: completion)
        
    }
    
    
    
    
    func share(completion: @escaping (Data?) -> Void) {
        let urlString = baseURL + "share/c5c6dc9a-c6e2-4ae4-9ee4-d7036cc01d8a"
        dataFetcher.fetchGenericJSONData(urlString: urlString, response: completion)
    }
    
    
    
}







