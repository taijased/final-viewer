//
//  LoginTextFieldView.swift
//  swift-starter-kit
//
//  Created by Максим Спиридонов on 18.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit



class LoginTextFieldView: UIView {
    
    
    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .random()
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor.Gray.light
        return view
    }()
    
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(string: "Введите логин или e-mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.Gray.primary])
        textField.textColor = UIColor.Gray.primary
        textField.font = UIFont.getTTNormsFont(type: .medium, size: 14)
        textField.tintColor = UIColor.Gray.primary
        textField.addTarget(self, action: #selector(loginTextFieldDidBegin(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(loginTextFieldDidEnd(_:)), for: .editingDidEnd)
        textField.returnKeyType = .done
        return textField
    }()
    
    @objc fileprivate func loginTextFieldDidBegin(_ textField: UITextField) {
        
    }
    
    @objc fileprivate func loginTextFieldDidEnd(_ textField: UITextField) {
        
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        setupLayers()
    }
    
    
    
    
    fileprivate func setupLayers() {
        
        addSubview(mainView)
        mainView.fillSuperview()
        
        
        mainView.addSubview(textField)
        textField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 22).isActive = true
        textField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -22).isActive = true
        textField.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        textField.delegate = self

        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




extension LoginTextFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        
        textField.resignFirstResponder()
        return true
    }
}
