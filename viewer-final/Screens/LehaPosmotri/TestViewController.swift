//
//  TestViewController.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 09.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    
    fileprivate let webImage: WebImageView = {
        let view = WebImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.set(imageURL: "https://www.itl.cat/pngfile/big/0-2232_free-download-hd-nature-wallpapers-for-mobile-home.jpg")
        return view
    }()
    
    
    
    let controls = ARViewControls()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webImage)
        webImage.fillSuperview()
        
        view.addSubview(controls)
        controls.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        controls.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        controls.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        controls.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
}
