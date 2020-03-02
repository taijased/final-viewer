//
//  RequestMessage.swift
//  TestIOS
//
//  Created by Alexey Antipin on 02/11/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import Foundation

struct RequestMessage
{
    
    var id: String
    var method: String
    var parameters: [Any]
    
    init(id: String, method: String, parameters: [Any])
    {
        self.id = id
        self.method = method
        self.parameters = parameters
    }
    
    init?(inputJson: String) throws
    {
        do
        {
            guard let data = inputJson.data(using: .utf8) else { return nil }
            
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            guard
                
                let id = json["id"] as? String,
                let method = json["method"] as? String,
                let parameters = json["parameters"] as? [Any]
                
                else
            {
                return nil
            }
            
            self.id = id
            self.method = method
            self.parameters = parameters
        }
        catch
        {
            let error = MessageError.messageReceiveError(message: "Не удалось обработать Request message")
            throw error
        }
    }
    
    func createMessage() throws -> String!
    {
        do
        {
            let dict = ["id" : id, "method" : method, "parameters" : parameters] as [String : Any]
            let json = try JSONSerialization.data(withJSONObject: dict, options: [])
            return String(data: json, encoding: .utf8)
        }
        catch
        {
            let error = MessageError.messageGenerationError(message: "Не удалось сформировать Request message")
            throw error
        }
    }
}




