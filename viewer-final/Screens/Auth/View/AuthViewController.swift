//
//  AuthViewController.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 18.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

final class AuthViewController: UIViewController {
    
    
    
    fileprivate let logoView: ARQIconView = {
        let view = ARQIconView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fillColor = UIColor.Primary.primary
        return view
    }()
    
    fileprivate var viewModel: AuthViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = AuthViewModel()
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        
        
        
        view.addSubview(logoView)
        logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 104).isActive = true
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        
        guard let viewModel = viewModel else { return }
        view.addSubview(viewModel.login)
        viewModel.login.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 80).isActive = true
        viewModel.login.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        viewModel.login.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        viewModel.login.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        
        view.addSubview(viewModel.password)
        viewModel.password.topAnchor.constraint(equalTo: viewModel.login.bottomAnchor, constant: 50).isActive = true
        viewModel.password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        viewModel.password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        viewModel.password.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        
        view.addSubview(viewModel.enterButton)
        viewModel.enterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        viewModel.enterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        viewModel.enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        viewModel.enterButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
    }
    
    
    
    
    // MARK: settings Navigation bar
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
