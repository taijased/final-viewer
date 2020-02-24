//
//  TextFieldModel.swift
//  custom-textfield
//
//  Created by Максим Спиридонов on 20.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//



import UIKit


enum TextFieldStatus {
    case error(msg: String)
    case done
    case empty
    case write
    
}

enum TextFieldIconStatus {
    case done
    case error
    case eye
    case closeEye
    case empty
}



enum TextFieldType {
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


protocol TextFieldProtocol {
    var fieldStatus: TextFieldStatus { get }
    var iconStatus: TextFieldIconStatus { get }
    var updateUI: (() -> Void)? { get set }
    func validate(value: String)
    func getType() -> TextFieldType
    func textFieldDidBegin(_ textField: UITextField)
}

extension TextFieldProtocol {
    
}



class TextFieldFactory {
    static func produceTextFieldTextField(type: TextFieldType) -> TextFieldProtocol {
        var textField: TextFieldProtocol
        switch type {
        case .email: textField = EmailFieldViewModel()
        case .password: textField = PasswordFieldViewModel()
        
        }
        return textField
    }
}

