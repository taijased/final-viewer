//
//  ResponseMessage.swift
//  TestIOS
//
//  Created by Alexey Antipin on 02/11/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import Foundation

struct ResponseMessage
{
    var id: String
    var message: String
    var hasError: Bool
    var result: Any
    
    init(id: String, message: String, hasError: Bool, result: Any)
    {
        self.id = id
        self.message = message
        self.hasError = hasError
        self.result = result
    }
    
    init?(inputJson:  String) throws
    {
        do
        {
            guard let data = inputJson.data(using: .utf8) else { return nil }
            
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            guard
                
                let id = json["id"] as? String,
                let message = json["message"] as? String,
                let hasError = json["hasError"] as? Bool,
                let result = json["result"]
                
                else
            {
                return nil
            }
            
            self.id = id
            self.message = message
            self.hasError = hasError
            self.result = result
        }
            
        catch
        {
            let error = MessageError.messageReceiveError(message: "Не удалось обработать Response Message")
            throw error
        }
        

    }
    
    func createMessage() throws -> String!
    {
        do
        {
            let dict = ["id" : id, "message" : message, "hasError" : hasError, "result" : result] as [String : Any]
            let json = try JSONSerialization.data(withJSONObject: dict, options: [])
            return String(data: json, encoding: .utf8)
        }
        catch
        {
            let error = MessageError.messageReceiveError(message: "Не удалось сформировать Respponse Message")
            throw error
        }
    }
    
}




