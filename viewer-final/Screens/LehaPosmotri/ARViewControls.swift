//
//  ARViewControls.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 04.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit


enum ARViewControlsEnum {
    case close
    case openAR
    case open3D
}

protocol ARViewControlsDelegate: class {
    func controlsActions(_ type: ARViewControlsEnum)
}

final class ARViewControls: UIView {
    
    weak var delegate: ARViewControlsDelegate?
    
    
    
    
    fileprivate let closeButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.Red.primary
        button.setImage(UIImage(named: "close-white"), for: .normal)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    
    
    fileprivate let arViewControl: ARViewControlItem = {
        
        let view = ARViewControlItem(frame: .zero, labelText: "AR", active: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        return view
    }()
    
    
    fileprivate let threeDViewControl: ARViewControlItem = {
        
        
        let view = ARViewControlItem(frame: .zero, labelText: "3D", active: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        return view
    }()
    
    
    
    
    
    
    
    @objc fileprivate func closeButtonTapped(_ sender: UIButton) {
        sender.flash()
        delegate?.controlsActions(.close)
    }
    
    @objc fileprivate func arButtonTapped() {
        print(#function)
        threeDViewControl.setupDefault()
        arViewControl.setupActive()
        delegate?.controlsActions(.openAR)
    }
    
    @objc fileprivate func threedButtonTapped() {
        
        print(#function)
        
        threeDViewControl.setupActive()
        arViewControl.setupDefault()
        delegate?.controlsActions(.open3D)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    
    fileprivate func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        addSubview(closeButton)
        closeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        
        
        addSubview(arViewControl)
        arViewControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        arViewControl.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 35.5).isActive = true
        arViewControl.widthAnchor.constraint(equalToConstant: 70).isActive = true
        arViewControl.heightAnchor.constraint(equalToConstant: 56).isActive = true
        arViewControl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(arButtonTapped)))
        
        
        addSubview(threeDViewControl)
        threeDViewControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        threeDViewControl.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -35.5).isActive = true
        threeDViewControl.widthAnchor.constraint(equalToConstant: 70).isActive = true
        threeDViewControl.heightAnchor.constraint(equalToConstant: 56).isActive = true
        threeDViewControl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(threedButtonTapped)))
        
        
        
    }
    
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
