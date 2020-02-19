//
//  UIView+Border.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 18.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

extension UIView {
    
    enum ViewBorder: String {
        case left, right, top, bottom
    }
    
    func add(Border border: ViewBorder, withColor color: UIColor = UIColor.lightGray, andWidth width: CGFloat = 1.0) {
        
        let borderView = UIView()
        borderView.backgroundColor = color
        borderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(borderView)
        NSLayoutConstraint.activate(getConstrainsFor(forView: borderView, WithBorderType: border, andWidth: width))
    }
    
    func changeBorderColor(color: UIColor) {
        self.subviews.first?.backgroundColor = color
    }
    
    
    private func getConstrainsFor(forView borderView: UIView, WithBorderType border: ViewBorder, andWidth width: CGFloat) -> [NSLayoutConstraint] {
        
        let height = borderView.heightAnchor.constraint(equalToConstant: width)
        let widthAnchor = borderView.widthAnchor.constraint(equalToConstant: width)
        let leading = borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let trailing = borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let top = borderView.topAnchor.constraint(equalTo: self.topAnchor)
        let bottom = borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        switch border {
            
        case .bottom:
            return [bottom, leading, trailing, height]
            
        case .top:
            return [top, leading, trailing, height]
            
        case .left:
            return [top, bottom, leading, widthAnchor]
            
        case .right:
            return [top, bottom, trailing, widthAnchor]
        }
    }
}
