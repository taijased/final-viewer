//
//  AuthViewModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 18.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit


protocol AuthViewModelType {
    var login: TextFieldView { get }
    var password: TextFieldView { get }
    var enterButton: UIButton { get }
}



class AuthViewModel: AuthViewModelType {
    
    let login: TextFieldView
    let password: TextFieldView
    
    let enterButton: UIButton = {
        let button  = UIButton.getCustomButton(label: "Login")
        button.titleLabel?.font = UIFont.getTTNormsFont(type: .medium, size: 16)
        return button
    }()
    
    @objc func enterButtonTapped(_ sender: UIButton) {
        sender.flash()
        print(#function)
    }
    
    init() {
        
        login = TextFieldView(frame: .zero, viewModel: TextFieldFactory.produceTextFieldTextField(type: .email))
        password = TextFieldView(frame: .zero, viewModel: TextFieldFactory.produceTextFieldTextField(type: .password))
        
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
    }
}
