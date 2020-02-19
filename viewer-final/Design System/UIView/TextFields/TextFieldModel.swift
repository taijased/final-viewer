//
//  TextFieldModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 19.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation



enum FieldType {
    case email
    case password
    
    func getLabelName() -> String {
        switch self {
        case .email:
            return "Login"
        case .password:
            return "Password"
        }
    }
    func getPlaceholderName() -> String {
        switch self {
        case .email:
            return "Enter Your Login or E-mail"
        case .password:
            return "Enter Your Password"
        }
    }
}


enum FieldStatus {
    case error(msg: String)
    case done
    case empty
    case write
    
}

enum FieldIconStatus {
    case done
    case error
    case eye
    case closeEye
    case empty
}


