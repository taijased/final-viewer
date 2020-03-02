//
//  UNCommunicatorProtocol.swift
//  UnityAsLib-Native
//
//  Created by Alexey Antipin on 06/11/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import Foundation

protocol UNCommunicatorProtocol: NativeCallsProtocol
{
    var unityFramework: UnityFramework! {set get}
    
    func Execute(_ sender: Any!)
    
    func ResponseExecute(_ sender: Any!)
  
    func executeUnity(methodName: String, parameters: [Any], callback: @escaping UNCallback)

    func UnityLogging(_ sender: Any!)

}
