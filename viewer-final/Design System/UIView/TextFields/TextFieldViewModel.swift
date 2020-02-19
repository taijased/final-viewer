//
//  TextFieldViewModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 19.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit




protocol TextFieldViewModelType {
    var type: FieldType { get }
    var fieldStatus: FieldStatus { get }
    var iconStatus: FieldIconStatus { get }
    func validate(value: String)
    var updateUI: (() -> Void)? { get set }
    func textFieldDidBegin(_ textField: UITextField)
    
    
}




class TextFieldViewModel: TextFieldViewModelType {
    
    
    
    
    var updateUI: (() -> Void)?
    var type: FieldType
    var fieldStatus: FieldStatus
    var iconStatus: FieldIconStatus
    
    init(type: FieldType) {
        self.type = type
        self.fieldStatus = .empty
        self.iconStatus = .empty
    }
    
    
    
    func validate(value: String) {
        print(#function)
        switch type {
        case .email:
            
            if self.validateEmail(value) {
                fieldStatus = .done
                iconStatus = .done
            } else {
                iconStatus = .error
                fieldStatus = .error(msg: "Check your mail address again")
            }
            
        case .password:
            
            if validatePassword(value).0 {
                fieldStatus = .done
                iconStatus = .eye
            } else {
                iconStatus = .eye
                fieldStatus = .error(msg: validatePassword(value).1!)
            }
        }
        
        
        self.updateUI?()
    }
    
    
    fileprivate func validateEmail(_ value: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: value)
    }
    
    fileprivate func validatePassword(_ value: String)  -> (Bool, String?) {
        
        
        
        //        let chars = Array("qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM,.?><:;%^&*()-_+=\'\"][{}!@#1234567890")
        
        if value.isEmpty {
            return (false, "Некорректный пароль")
        }
        
        if value.count < 8 {
            return (false, "Длина пароля менее 8 символов")
        }
        
        if value == value.lowercased() {
            return (false, "Пароль не содержит заглавных букв")
        }
        
        if value == value.uppercased() {
            return (false, "Пароль не содержит заглавных букв")
        }
        
        
        
        
        return (true, nil)
    }
    
    
    
    
    func textFieldDidBegin(_ textField: UITextField) {
        
        switch type {
            
        case .email:
            iconStatus = .empty
            fieldStatus = .write
        case .password:
            iconStatus = .eye
            fieldStatus = .write
            
        }
        
        self.updateUI?()
    }
    
    
    
}

