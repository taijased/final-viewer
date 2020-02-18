//
//  ARQIconView.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 18.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit



class ARQIconView: UIView {
    
    
    var fillColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let fillColor = fillColor else { return }
        ARQLogo.drawViewerLogo(frame: rect, resizing: .aspectFit, fillColor: fillColor)
    }
}

