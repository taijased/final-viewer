
//  TestViewController.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 04.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    
    let controls = ARViewControls()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(controls)
        controls.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        controls.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        controls.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        controls.heightAnchor.constraint(equalToConstant: 80).isActive = true
        controls.delegate = self
    }
    
    
}

extension TestViewController: ARViewControlsDelegate {
    func controlsActions(_ type: ARViewControlsEnum) {
        switch type {
        case .close:
            print(type)
        case .openAR:
            print(type)
        case .open3D:
            print(type)
        }
    }
}
