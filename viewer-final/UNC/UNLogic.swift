//
//  UNLogic.swift
//  UnityAsLib-Native
//
//  Created by Alexey Antipin on 03/11/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import Foundation

class UNLogic: NSObject
{
    @objc func helloUnity(_ sender: [Any]!) -> [AnyObject]
    {
        print("Hello Unity")
        print(sender)
   
        return [NSNumber(value: 153518), NSString(string: "hui")]
    }
}
