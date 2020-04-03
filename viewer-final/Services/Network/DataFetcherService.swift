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
    var fileLocation: ((URL?) -> ())?
      
    
    fileprivate let baseURL = "https://handshake.arq.su/vl/"
//    fileprivate let baseURL = "http://192.168.0.113:5000/"
    
    
    
    var dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
        self.dataFetcher.onProgress = { [weak self] progress in
            self?.onProgress?(progress)
        }
        
        self.dataFetcher.fileLocation = { [weak self] url in
            self?.fileLocation?(url)
        }
    }
   
    func uploadFile(filePath: URL, completion: @escaping (UploadingResponse?) -> Void) {
        let urlString = baseURL + "share"
        dataFetcher.uploadGenericData(urlString: urlString, filePath: filePath, response: completion)
    }
    
    
    func downloadFile(guid: String) {
        let urlString = baseURL + "share/\(guid)"
        dataFetcher.fetchData(urlString: urlString)
    }
    
    
    
}







