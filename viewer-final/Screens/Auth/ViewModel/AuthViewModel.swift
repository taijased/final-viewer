//
//  AuthViewModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 18.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation


protocol AuthViewModelType {
    var login: TextFieldView { get }
    var password: TextFieldView { get }
}



class AuthViewModel: AuthViewModelType {
    
    let login: TextFieldView
    let password: TextFieldView
    
    init() {
        
        login = TextFieldView(frame: .zero, viewModel: TextFieldViewModel(type: .email))
        password = TextFieldView(frame: .zero, viewModel: TextFieldViewModel(type: .password))
        
        
        
    }
}
