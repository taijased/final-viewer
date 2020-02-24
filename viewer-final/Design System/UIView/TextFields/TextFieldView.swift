//
//  TextFieldView.swift
//  custom-textfield
//
//  Created by Максим Спиридонов on 20.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit



final class TextFieldView: UIView {
    
    
    var viewModel: TextFieldProtocol?
    
    fileprivate let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 1
        let color = UIColor.Gray.extraLight
        color.withAlphaComponent(0.1)
        view.add(Border: .bottom, withColor: color, andWidth: 2.0)
        return view
    }()
    
    
    
    fileprivate let iconView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "done"), for: .normal)
        button.layer.masksToBounds = false
        button.alpha = 0
        return button
    }()
    
    
    
    
    fileprivate let errorLabel: UILabel = {
        let label = UILabel.H5.regular
        label.textColor = UIColor.Red.primary
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Check your mail address again"
        label.alpha = 0
        return label
    }()
    
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel.H5.regular
        label.textColor = UIColor.Gray.light
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.textColor = UIColor.Gray.gray
        textField.font = UIFont.getTTNormsFont(type: .regular, size: 16)
        textField.tintColor = UIColor.Gray.gray
        textField.returnKeyType = .done
        return textField
    }()
    
    
    
    init(frame: CGRect, viewModel: TextFieldProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        
        self.viewModel?.updateUI = { [weak self] in
            self?.updateUI()
        }
        
        
        setupUI()
    }
    
    
    
    fileprivate func setupUI() {
        
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        
        
        guard let viewModel = viewModel else { return }
        
        
        
        
        self.titleLabel.text = viewModel.getType().getLabelName()
        self.textField.attributedPlaceholder = NSAttributedString(string: viewModel.getType().getPlaceholderName(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.Gray.extraLight])
        
        
        
        switch viewModel.getType() {
       
        case .password:
            self.textField.isSecureTextEntry = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapIconView(recognzier:)))
            iconView.addGestureRecognizer(tap)
        case .email:
            print("email")

        }
        
        
        
        
        
        addSubview(mainView)
        mainView.fillSuperview()
        
        mainView.addSubview(textField)
        textField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        textField.delegate = self
        
        mainView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -12.5).isActive = true
        
        
        mainView.addSubview(errorLabel)
        errorLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 25).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        
        
        mainView.addSubview(iconView)
        iconView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -19).isActive = true
        iconView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 18).isActive = true
        
        
        
        
        
        
        
    }
    
    
    @objc fileprivate func tapIconView(recognzier: UITapGestureRecognizer) {
        self.textField.isSecureTextEntry = !self.textField.isSecureTextEntry
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    fileprivate func updateUI() {
        guard let viewModel = viewModel else { return }
        updateIcon(value: viewModel.iconStatus)
        updateField(value: viewModel.fieldStatus)
    }
    
    
    fileprivate func updateField(value: TextFieldStatus) {
        var errorLabelAlpha: CGFloat = 0
        var errorLabelMSG: String = ""
        var borderColor: UIColor = .clear
        
        switch value {
        case .error(let msg):
            errorLabelMSG = msg
            errorLabelAlpha = 1
            borderColor = UIColor.Red.primary
        case .done:
            
            errorLabelAlpha = 0
            borderColor = UIColor.Green.primary
        case .empty:
            
            errorLabelAlpha = 0
            borderColor = UIColor.Gray.extraLight.withAlphaComponent(0.1)
            
        case .write:
            errorLabelAlpha = 0
            borderColor =  UIColor.Primary.primary
            
        }
        
        
        
        
        
        
        
        UIView.animate(withDuration: 0.25) {
            
            self.errorLabel.text = errorLabelMSG
            self.errorLabel.alpha = errorLabelAlpha
            
            
            self.mainView.changeBorderColor(color: borderColor)
            //            self.mainView.add(Border: .bottom, withColor: borderColor, andWidth: 2.0)
        }
        
    }
    
    
    
    fileprivate func updateIcon(value: TextFieldIconStatus) {
        
        
        var imageName: String = ""
        switch value {
        case .done:
            imageName = "done"
        case .error:
            imageName = "error"
        case .eye:
            imageName = "eye"
        case .closeEye:
            imageName = "error"
        case .empty:
            imageName = ""
        }
        
        UIView.animate(withDuration: 0.25) {
            if imageName.isEmpty {
                self.iconView.alpha = 0
            } else {
                //                self.iconView.set = UIImage(named: imageName)
                self.iconView.setImage(UIImage(named: imageName), for: .normal)
                self.iconView.alpha = 1
            }
        }
        
        
        
    }
}

extension TextFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        guard  let viewModel = viewModel, let value = textField.text else { return false }
        viewModel.validate(value: value)
        textField.resignFirstResponder()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        viewModel?.textFieldDidBegin(textField)
        return true;
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard  let viewModel = viewModel, let value = textField.text else { return }
        viewModel.validate(value: value)
    }
}
