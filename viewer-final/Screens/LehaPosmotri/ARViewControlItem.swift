//
//  ARViewControlItem.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 10.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit



class ARViewControlItem: UIView {
    
    
    fileprivate let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.getTTNormsFont(type: .medium, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hexValue: "#6C757E", alpha: 1)
        return label
    }()
    
    
    fileprivate let visualEffectView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.effect = UIBlurEffect(style: .light)
        return view
    }()
       
    
    
    fileprivate let arViewControl: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    
    
    init(frame: CGRect, labelText: String, active: Bool?) {
        super.init(frame: frame)
        self.label.text = labelText
        if active != nil {
            self.setupActive()
        }
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupUI() {
        
        translatesAutoresizingMaskIntoConstraints = false
    
        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        
        addSubview(label)
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    
    func setupActive() {
        UIView.animate(withDuration: 0.2) {
            self.label.textColor = .white
            self.backgroundColor = UIColor.Primary.primary
            self.visualEffectView.effect = nil
        }
    }
    
    func setupDefault() {
        UIView.animate(withDuration: 0.2) {
            self.label.textColor = UIColor(hexValue: "#6C757E", alpha: 1)
            self.backgroundColor = .clear
            self.visualEffectView.effect = UIBlurEffect(style: .light)
        }
    }
    
    
}
