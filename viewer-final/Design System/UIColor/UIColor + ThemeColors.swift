//
//  UIColor + ThemeColors.swift
//  swift-starter-kit
//
//  Created by Максим Спиридонов on 18.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit.UIColor





protocol BlackColors {
    static var primary: UIColor { get }
    static var gray: UIColor { get }
    static var light: UIColor { get }
}

protocol RedColors {
    static var primary: UIColor { get }
}

protocol BlueColors {
    static var primary: UIColor { get }
}




protocol SocialColor {
    static var facebook: UIColor { get }
    static var vk: UIColor { get }
    static var twitter: UIColor { get }
    static var apple: UIColor { get }
}



protocol GrayColor {
    static var primary: UIColor { get }
    static var primaryLight: UIColor { get }
    static var gray: UIColor { get }
    static var light: UIColor { get }
    static var extraLight: UIColor { get }
}



protocol GreenColors {
    static var primary: UIColor { get }
}


protocol PrimaryColor {
    static var primary: UIColor { get }
    static var light: UIColor { get }
    
}






//MARK: - UIColor Theme
extension UIColor {
    
    enum Primary: PrimaryColor {
        static let primary = UIColor(hexValue: "#4737D6", alpha: 1.0)!
        static let light = UIColor(hexValue: "#E5FBFB", alpha: 1.0)!
    }
    
    
    
    enum Social: SocialColor {
        static let apple = UIColor.black
        static let vk = UIColor(hexValue: "#1E88E5", alpha: 1.0)!
        static let facebook = UIColor(hexValue: "#4267B2", alpha: 1.0)!
        static let twitter = UIColor(hexValue: "#03A9F4", alpha: 1.0)!
    }
    
    
    
    
    
    // garbage
    
    enum Green: GreenColors {
        static let primary = UIColor(hexValue: "#02AB17", alpha: 1.0)!
    }
    
    
    enum Gray: GrayColor {
        static let primary = UIColor(hexValue: "#EEEEF0", alpha: 1.0)!
        static let primaryLight = UIColor(hexValue: "#F0F0F0", alpha: 1.0)!
        static let gray = UIColor(hexValue: "#4C4B5E", alpha: 1.0)!
        static let light = UIColor(hexValue: "#C7C7D4", alpha: 1.0)!
        static let extraLight = UIColor(hexValue: "#C7C7D4", alpha: 0.4)!
    }
    
    
    
    
    
    
    
    
    enum Black: BlackColors {
        static let primary: UIColor = UIColor(hexValue: "#19191C", alpha: 1.0)!
        
        static let gray: UIColor = UIColor(hexValue: "#2C2C2E", alpha: 1.0)!
        
        static let light: UIColor = UIColor(hexValue: "#1C1C1E", alpha: 1.0)!
        
    }
    
    enum Red: RedColors {
        static var primary: UIColor = UIColor(hexValue: "#D00202", alpha: 1.0)!
    }
    
    enum Blue: BlueColors {
        static var primary: UIColor = UIColor(hexValue: "#3017C2", alpha: 1.0)!
    }
    
}
