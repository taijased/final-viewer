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
    static var light: UIColor { get }
}



protocol YellowColors {
    static var primary: UIColor { get }
}


protocol PrimaryColor {
    static var primary: UIColor { get }
    static var light: UIColor { get }
    
}






//MARK: - UIColor Theme
extension UIColor {
    
    enum Primary: PrimaryColor {
        static let primary = UIColor(hexValue: "#00D6D8", alpha: 1.0)!
        static let light = UIColor(hexValue: "#E5FBFB", alpha: 1.0)!
    }
    
    
    
    enum Social: SocialColor {
        static let apple = UIColor.black
        static let vk = UIColor(hexValue: "#1E88E5", alpha: 1.0)!
        static let facebook = UIColor(hexValue: "#4267B2", alpha: 1.0)!
        static let twitter = UIColor(hexValue: "#03A9F4", alpha: 1.0)!
    }
    
    
    
    
    
    // garbage
    
    enum Yellow: YellowColors {
        static let primary = UIColor(hexValue: "#FEEB01", alpha: 1.0)!
    }
    
    
    enum Gray: GrayColor {
        static let primary = UIColor(hexValue: "#AFC1C4", alpha: 1.0)!
        static let primaryLight = UIColor(hexValue: "#6D8387", alpha: 1.0)!
        static let light = UIColor(hexValue: "#F6F7F9", alpha: 1.0)!
    }
    
    
    
    
    
    
    
    
    enum Black: BlackColors {
        static let primary: UIColor = UIColor(hexValue: "#19191C", alpha: 1.0)!
        
        static let gray: UIColor = UIColor(hexValue: "#88888C", alpha: 1.0)!
        
        static let light: UIColor = UIColor(hexValue: "#BABABC", alpha: 1.0)!
    }
    
    enum Red: RedColors {
        static var primary: UIColor = UIColor(hexValue: "#DC3A42", alpha: 1.0)!
    }
    
    enum Blue: BlueColors {
        static var primary: UIColor = UIColor(hexValue: "#3017C2", alpha: 1.0)!
    }
    
}
