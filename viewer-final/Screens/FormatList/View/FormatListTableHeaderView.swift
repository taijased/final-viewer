//
//  FormatListTableHeaderView.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit


final class FormatListTableHeaderView: UIView {
    
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel.H1.bold
        label.text = "Supported formats"
        label.textColor = UIColor.Primary.primary
        label.font = UIFont.getTTNormsFont(type: .bold, size: 32)
        label.textColor = UIColor.Primary.primary
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
    }
    
}
