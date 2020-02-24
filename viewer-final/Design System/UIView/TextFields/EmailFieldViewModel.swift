//
//  EmailFieldViewModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 21.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit


//MARK: - Email
class EmailFieldViewModel: TextFieldProtocol {
    
    var updateUI: (() -> Void)?
    var fieldStatus: TextFieldStatus = .empty
    var iconStatus: TextFieldIconStatus = .empty
    
    init() {}
    
    func getType() -> TextFieldType { return .email }
    
    func validate(value: String) {
        if self.validateEmail(value) {
            fieldStatus = .done
            iconStatus = .done
        } else {
            iconStatus = .error
            fieldStatus = .error(msg: "Check your mail address again")
        }
        
        self.updateUI?()
    }
    
    func textFieldDidBegin(_ textField: UITextField) {
        
        iconStatus = .empty
        fieldStatus = .write
        self.updateUI?()
    }
    
    
    
    fileprivate func validateEmail(_ value: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: value)
    }
}

