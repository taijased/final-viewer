//
//  PasswordFieldViewModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 21.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit


//MARK: - Password
class PasswordFieldViewModel: TextFieldProtocol {
  
    
    
    var updateUI: (() -> Void)?
    var fieldStatus: TextFieldStatus = .empty
    var iconStatus: TextFieldIconStatus = .empty
    
    init() {}
    
    func getType() -> TextFieldType { return .password }
    
    func textFieldDidBegin(_ textField: UITextField) {
        iconStatus = .eye
        fieldStatus = .write
        self.updateUI?()
    }
    
    
    func validate(value: String) {
        
        if validatePassword(value).0 {
            fieldStatus = .done
            iconStatus = .eye
        } else {
            iconStatus = .eye
            fieldStatus = .error(msg: validatePassword(value).1!)
        }
        
        self.updateUI?()
    }
    
    
    fileprivate func validatePassword(_ value: String)  -> (Bool, String?) {
        
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
    
}

