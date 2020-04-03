//
//  NetworkService.swift
//  swift-starter-kit
//
//  Created by Максим Спиридонов on 18.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation
import MobileCoreServices




protocol Networking {
    func request(urlString: String, completion: @escaping(Data?, Error?) -> Void)
    func request(urlString: String, httpBody: Data, completion: @escaping(Data?, Error?) -> Void)
    func request(urlString: String, filePathURL: URL, completion: @escaping(Data?, Error?) -> Void)
    var onProgress: ((Double) -> ())? { get set}
}

class NetworkService: NSObject, Networking {
    
    var onProgress: ((Double) -> ())?
    
    func request(urlString: String, completion: @escaping(Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    
    func request(urlString: String, httpBody: Data, completion: @escaping(Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "post"
        request.httpBody = httpBody
        request.allHTTPHeaderFields = prepareDefaultHeader()
        
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    
    fileprivate func prepareDefaultHeader() -> [String: String]? {
        var headers = [String: String]()
        //        headers["Content-Type"] = "multipart/form-data"
        headers["Content-Type"] = "application/octet-stream"
        //        headers["Accept"] = "application/json; charset=utf-8"
        return headers
    }
    
    
    
    
//        func request(urlString: String, filePathURL: URL, completion: @escaping(Data?, Error?) -> Void) {
//            guard let url = URL(string: urlString) else { return }
//            var request = URLRequest(url: url)
//            request.httpMethod = "post"
//            request.allHTTPHeaderFields = prepareDefaultHeader()
//            let uploadTask = createUploadTask(from: request, filePath: filePathURL, completion: completion)
//            uploadTask.resume()
//        }
//
    
    
    func request(urlString: String, filePathURL: URL, completion: @escaping(Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let parameters = ["email": "taijased@gmail.com", "name": "Maxim Spiridonov"]


        guard let zip = FileZipModel(filePath: filePathURL, forKey: "zip") else { return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = generateBoundary()
        let dataBody = createDataBody(withParameters: parameters, zipFiles: [zip], boundary: boundary)
        request.httpBody = dataBody
        request.setValue("multipart/form-data; boundary=\"\(boundary)\"", forHTTPHeaderField: "Content-Type")
        request.setValue("\(dataBody.count)", forHTTPHeaderField:"Content-Length")
        print(String(decoding: dataBody, as: UTF8.self))

        let uploadTask = createUploadTask(from: request, filePath: filePathURL, completion: completion)
        uploadTask.resume()
    }
    
    
    
    fileprivate func createUploadTask(from request: URLRequest, filePath: URL, completion: @escaping (Data?, Error?) -> Void) -> URLSessionUploadTask {
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        return session.uploadTask(with: request, fromFile: filePath) { (responseData, response, error) in
            DispatchQueue.main.async {
                completion(responseData, error)
            }
        }
    }
    
    
    
    
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    //    fileprivate func createUploadTask(from request: URLRequest, filePath: URL, completion: @escaping (Data?, Error?) -> Void) -> URLSessionUploadTask {
    //        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
    //        return session.uploadTask(with: request, fromFile: filePath) { (responseData, response, error) in
    ////            if let httpResponse = response as? HTTPURLResponse {
    ////                switch httpResponse.statusCode {
    ////                case 200..<300:
    ////                    print("Success")
    ////                case 400..<500:
    ////                    print("Request error")
    ////                case 500..<600:
    ////                    print("Server error")
    ////                case let otherCode:
    ////                    print("Other code: \(otherCode)")
    ////                }
    ////            }
    //
    //            DispatchQueue.main.async {
    //                completion(responseData, error)
    //            }
    //        }
    //
    //    }
}


extension NetworkService {
    func createDataBody(withParameters params: [String: String]?, zipFiles: [FileZipModel]?, boundary: String) -> Data {
        
        //        let lineBreak = "\r\n"
        //        var body = Data()
        //
        //        if let parameters = params {
        //            for (key, value) in parameters {
        //                body.append("--\(boundary + lineBreak)")
        //                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
        //                body.append("\(value + lineBreak)")
        //            }
        //        }
        //
        //        if let zipFiles = zipFiles {
        //            for zipItem in zipFiles {
        //                body.append("--\(boundary + lineBreak)")
        ////                body.append("Content-Type: \(zipItem.mimeType + lineBreak + lineBreak)")
        //                body.append("Content-Disposition: form-data; name=\"\(zipItem.key)\"; filename=\"\(zipItem.filename)\"\(lineBreak)")
        ////                body.append(zipItem.data)
        //                body.append(lineBreak)
        //            }
        //        }
        //
        //
        //        body.append("--\(boundary)--\(lineBreak)")
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        
        if let zipFiles = zipFiles {
            for zipItem in zipFiles {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Type: \(zipItem.mimeType + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(zipItem.key)\"; filename=\"\(zipItem.filename)\"\(lineBreak + lineBreak)")
                body.append(zipItem.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        print(body.count)
        
        return body
    }
    
    func generateBoundary() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
}





extension NetworkService: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask,
                    didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        
        DispatchQueue.main.async {
            self.onProgress?(progress)
        }
        
    }
}



extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
