//
//  UNCommunicator.swift
//  UnityAsLib-Native
//
//  Created by Alexey Antipin on 03/11/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import Foundation

typealias UNCallback = (Any?, Error?) -> ()

class UNCommunicator:NSObject, UNCommunicatorProtocol
{
    var unityFramework: UnityFramework!
    
    private var historyCalls = [String: UNCallback]()
    
    private var logic: UNLogic
    
    private var proxy: UNProxy
    
    init(logic: UNLogic, proxy: UNProxy)
    {
        self.logic = logic
        self.proxy = proxy
    }
    
    func sendMessage(_ method: String!, _ parameter: String!)
    {  
        guard let method = method, let parameter = parameter else {return}
        let selector = Selector(method + ":")
        self.perform(selector, with: parameter)
    }
    
    @objc func Execute(_ sender: Any!)
    {
        let json = sender as! String
        let unityRequest: RequestMessage?
        do
        {
            unityRequest = try RequestMessage(inputJson: json)
        }
        catch
        {
            print(error)
            return
        }
        guard let request = unityRequest else { return }
        let selector = Selector(request.method + ":")
        let result: [Any]
        
        //        do
        //        {
        
        result = try logic.perform(selector, with: request.parameters).takeUnretainedValue() as! [Any]
        
        
        //        }
        //        catch
        //        {
        //            let response = ResponseMessage(id: request.id, message: "Произошла ошибка во время выполнения метода \(request.method)", hasError: true, result: [])
        //            responseUnity(response: response)
        //            print("Произошла ошибка при выполнении метода \(request.method)")
        //            return
        //        }
        
        
        let response = ResponseMessage(id: request.id, message: "", hasError: false, result: result)
        responseUnity(response: response)
        
        
    }
    
    @objc func ResponseExecute(_ sender: Any!)
    {
        let json = sender as! String
        var unityResponse: ResponseMessage?
        do
        {
            unityResponse = try ResponseMessage(inputJson: json)
        }
        catch
        {
            print(error)
            return
        }
        guard let response = unityResponse  else { return }
        
        guard let callback = historyCalls[response.id] else
        {
            print("Не найден callback для id: \(response.id)")
            return
        }
        
        if response.hasError
        {
            let error = MethodsExecutionError.unityError(message: "Ошибка \(response.message)")
            
            
            callback(response.result, error)
            return
        }
        callback(response.result, nil)
    }
    
    @objc func UnityLogging(_ sender: Any!)
    {
        print(sender)
    }
    
    func executeUnity(methodName: String, parameters: [Any], callback: @escaping UNCallback)
    {
        var id = NSUUID().uuidString.lowercased()
        
        while historyCalls.contains(where: {(key, value) in return key == id })
        {
            id = NSUUID().uuidString.lowercased()
            
        }
        
        historyCalls.updateValue(callback, forKey: id)
        
        let request = RequestMessage(id: id, method: methodName, parameters: parameters)
        
        do
        {
            let requestJson = try request.createMessage()
            unityFramework.sendMessageToGO(withName: "Communicator", functionName: "Execute", message: requestJson)
        }
            
        catch
        {
            print(error)
        }
        
    }
    
    func responseUnity(response: ResponseMessage)
    {
        do
        {
            let responseJson = try response.createMessage()
            unityFramework.sendMessageToGO(withName: "Communicator", functionName: "ResponseExecute", message: responseJson)
        }
            
        catch
        {
            print(error)
        }
    }
    
    
}

enum  MessageError: Error
{
    case messageGenerationError(message: String)
    case messageReceiveError(message: String)
}

enum MethodsExecutionError: Error
{
    case unityError(message: String)
    case nativeError(message: String)
    
}

func handleMessageError(error: MessageError)
{
    switch error
    {
    case .messageReceiveError(let message):
        print(message)
    case .messageGenerationError(let message):
        print(message)
    }
}
