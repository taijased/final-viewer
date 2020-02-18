//
//  ViewController.swift
//  swift-starter-kit
//
//  Created by Максим Спиридонов on 18.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    
    fileprivate let infoLabel: UILabel = {
        let label = UILabel.H1.bold
        label.text = "TTNorms-Bold"
        label.textColor = .white
        label.font = UIFont.getTTNormsFont(type: .bold, size: 40)
        label.textAlignment = .center
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        
        self.view.alpha = 0
        view.backgroundColor = .random()
        view.addSubview(infoLabel)
        infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        infoLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1
        }
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
