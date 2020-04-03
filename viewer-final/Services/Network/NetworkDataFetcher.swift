//
//  NetworkDataFetcher.swift
//  swift-starter-kit
//
//  Created by Максим Спиридонов on 18.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation


protocol DataFetcher {
    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping(T?) -> Void)
    func uploadGenericJSONData<T: Decodable>(urlString: String, data: Data, response: @escaping(T?) -> Void)
    func uploadGenericData<T: Decodable>(urlString: String, filePath: URL, response: @escaping(T?) -> Void)
    var onProgress: ((Double) -> ())? { get set}
}

class NetworkDataFetcher: DataFetcher{
    
    var onProgress: ((Double) -> ())?
    
    var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
        self.networking.onProgress = { [weak self] progress in
            self?.onProgress?(progress)
        }
    }
    
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping(T?) -> Void) {
        networking.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("Failed  received requesting data", error)
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: T.self, from: data)
            response(decoded)
        }
    }
    
    
    func uploadGenericJSONData<T>(urlString: String, data: Data, response: @escaping (T?) -> Void) where T : Decodable {
        networking.request(urlString: urlString, httpBody: data) { (data, error) in
            if let error = error {
                print("Failed  received requesting data", error)
                response(nil)
            }
            
            
            let decoded = self.decodeJSON(type: T.self, from: data)
            response(decoded)
        }
    }

    
    func uploadGenericData<T: Decodable>(urlString: String, filePath: URL, response: @escaping(T?) -> Void) {
        networking.request(urlString: urlString, filePathURL: filePath) { (data, error) in
            if let error = error {
                print("Failed  received requesting data", error)
                response(nil)
            }
            let decoded = self.decodeJSON(type: T.self, from: data)
            response(decoded)
        }
    }
    
    
    
    
    fileprivate func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
            
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
    
}
