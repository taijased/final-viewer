//
//  UIButton + Theme.swift
//  swift-starter-kit
//
//  Created by Максим Спиридонов on 18.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit


protocol PrimaryButton {
    static var primary: UIButton { get }
    static var empty: UIButton { get }
    static var white: UIButton { get }
}



protocol SocialIconButton {
    static var facebook: UIButton { get }
    static var vk: UIButton { get }
    static var twitter: UIButton { get }
    static var apple: UIButton { get }
}



//MARK: - UIColor Theme
extension UIButton {
    
    
    
    enum Social: SocialIconButton {
        
        static let facebook: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "facebook"), for: .normal)
            button.backgroundColor = UIColor.Social.facebook
            button.layer.cornerRadius = 20
            button.layer.masksToBounds = false
            return button
        }()
        
        static let vk: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "vk"), for: .normal)
            button.backgroundColor = UIColor.Social.vk
            button.layer.cornerRadius = 20
            button.layer.masksToBounds = false
            return button
        }()
        
        static let twitter: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "twitter"), for: .normal)
            button.backgroundColor = UIColor.Social.twitter
            button.layer.cornerRadius = 20
            button.layer.masksToBounds = false
            return button
        }()
        
        static let apple: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "apple"), for: .normal)
            button.backgroundColor = UIColor.Social.apple
            button.layer.cornerRadius = 20
            button.layer.masksToBounds = false
            return button
        }()
    }
    
    enum Primary: PrimaryButton {
        
        static let primary: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor.Primary.light
            button.layer.cornerRadius = 20
            button.layer.masksToBounds = false
            button.setTitleColor(UIColor.Primary.primary, for: .normal)
            button.titleLabel!.font = UIFont.getTTNormsFont(type: TTNorms.medium, size: 14)
            return button
        }()
        static let empty: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .clear
            button.layer.cornerRadius = 20
            button.layer.masksToBounds = false
            button.titleLabel!.font = UIFont.getTTNormsFont(type: TTNorms.medium, size: 16)
            return button
        }()
        
        
        static let white: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .white
            button.layer.cornerRadius = 20
            button.layer.masksToBounds = false
            button.setTitleColor(UIColor.Primary.primary, for: .normal)
            button.titleLabel!.font = UIFont.getTTNormsFont(type: TTNorms.medium, size: 16)
            return button
        }()
        
    }
    
    
}
