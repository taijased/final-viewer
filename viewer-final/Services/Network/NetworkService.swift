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
//    func request(urlString: String, completion: @escaping(Data?, Error?) -> Void)
    func request(urlString: String)
    func request(urlString: String, filePathURL: URL, completion: @escaping(Data?, Error?) -> Void)
    var onProgress: ((Double) -> ())? { get set }
    var fileLocation: ((URL?) -> ())? { get set }
}

class NetworkService: NSObject, Networking {
    
    var onProgress: ((Double) -> ())?
    var fileLocation: ((URL?) -> ())?
    
    fileprivate let localFileFetcher: LocalFileFetcher = LocalFileFetcher()
    
    
    
    
    
    
    
    func request(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let downloadTask = createDownloadTask(url: url)
        downloadTask.earliestBeginDate = Date().addingTimeInterval(1)
        downloadTask.countOfBytesClientExpectsToSend = 512
        downloadTask.countOfBytesClientExpectsToReceive = 50 * 1024 * 1024
        downloadTask.resume()
    }
    
    
    
    
    private func createDownloadTask(url: URL) -> URLSessionDownloadTask {
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        return session.downloadTask(with: url)
    }
    
    
    
    
    
    
    
    
    
    
    
    func request(urlString: String, filePathURL: URL, completion: @escaping(Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        //        let parameters = ["email": "taijased@gmail.com", "name": "Maxim Spiridonov"]
        print(url)
        guard let zip = FileZipModel(filePath: filePathURL, forKey: "zip") else { return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = generateBoundary()
        let dataBody = createDataBody(withParameters: nil, zipFiles: [zip], boundary: boundary)
        request.httpBody = dataBody
        request.setValue("multipart/form-data; boundary=\"\(boundary)\"", forHTTPHeaderField: "Content-Type")
        request.setValue("\(dataBody.count)", forHTTPHeaderField:"Content-Length")
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        
    }
    
    
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        return session.dataTask(with: request) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200..<300:
                    print("Success")
                case 400..<500:
                    print("Request error")
                    completion(nil, error)
                case 500..<600:
                    print("Server error")
                    completion(nil, error)
                case let otherCode:
                    print("Other code: \(otherCode)")
                }
                print(httpResponse.statusCode)
            }
            
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
}


extension NetworkService {
    func createDataBody(withParameters params: [String: String]?, zipFiles: [FileZipModel]?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Type: text/plain\(lineBreak)")
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
        return body
    }
    
    func generateBoundary() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
}





extension NetworkService: URLSessionTaskDelegate {
    //Прогресс для отправки сообщения
    func urlSession(_ session: URLSession, task: URLSessionTask,
                    didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        DispatchQueue.main.async {
            self.onProgress?(progress)
        }
    }
    
}


extension NetworkService: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let httpResponse = downloadTask.response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
                print ("server error")
                self.fileLocation?(nil)
                return
        }
        self.localFileFetcher.addNewZip(location) { [weak self] url in
            DispatchQueue.main.async {
                self?.fileLocation?(url)
            }
        }
    }
    
    
    //Прогресс для скачивания
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
         
           let progress = Double(fileOffset) / Double(expectedTotalBytes)
           print("Download progress: \(progress)")
           
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
