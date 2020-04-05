//
//  ProjectsUploadView.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 31.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit


final class ProjectsUploadView: UIView {
    
    fileprivate let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.getTTNormsFont(type: .bold, size: 16)
        label.text = "0%"
        return label
    }()
    
    
    let loaderfirstView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.image = UIImage(named: "loaderfirst")
        return imageView
    }()
    
    let loadersecondView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.image = UIImage(named: "loadersecond")
        return imageView
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    
    func startUpload(_ progress: Double) {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.label.text = "\(Int(progress * 100))%"
        }
        
    }
    
    func startAnimation() {
        loaderfirstView.rotate(duration: 8)
        loadersecondView.rotate(duration: 4)
    }
    
    fileprivate func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(loaderfirstView)
        loaderfirstView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loaderfirstView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loaderfirstView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loaderfirstView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        
        addSubview(loadersecondView)
        loadersecondView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadersecondView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadersecondView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loadersecondView.widthAnchor.constraint(equalToConstant: 100).isActive = true
               
        
        
        
        addSubview(label)
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 2).isActive = true
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    func rotate(duration: Double = 4) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
}
