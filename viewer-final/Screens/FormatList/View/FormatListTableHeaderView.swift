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
        label.text = "SupportedFormat.title".localized
        label.textColor = UIColor.Primary.primary
        label.font = UIFont.getTTNormsFont(type: .bold, size: 32)
        label.textColor = UIColor.Primary.primary
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupUI() {
        addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true

        let titleLabelHeight: CGFloat = Bundle.main.preferredLocalizations.first == "en" ? 32 : 90
        titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight).isActive = true
             

        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if traitCollection.userInterfaceStyle == .light {
              titleLabel.textColor = UIColor.Primary.primary
          } else {
              titleLabel.textColor = .white
          }
    }
    
    
}
