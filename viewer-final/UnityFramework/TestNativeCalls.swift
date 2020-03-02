//
//  TestNativeCalls.swift
//  ARQ-Viewer
//
//  Created by Alexey Antipin on 05/09/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import Foundation

class  TestNativeCalls: NativeCallsProtocol {
    
    var currentResponse: ResponseMessage!
    {
        didSet
        {
            print(currentResponse)
        }
    }
    
    func sendMessage(_ method: String!, _ parameter: String!)
    {
        
    }
}
