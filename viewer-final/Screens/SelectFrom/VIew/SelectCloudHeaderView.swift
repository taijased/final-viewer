//
//  SelectCloudHeaderView.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit


final class SelectCloudHeaderView: UIView {
    
    
    
    let privacyPolicyView = SelectFilesDescriptionView()
    
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel.H1.bold
        label.text = "ChooseFile.title".localized
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
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        
        
      
        
        addSubview(privacyPolicyView)
        privacyPolicyView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        privacyPolicyView.widthAnchor.constraint(equalToConstant: 260).isActive = true
        privacyPolicyView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        let descLabelHeight = UILabel.getLabelSize(text: "ChooseFile.desc".localized, fontSize: 12, fontName: "TTNorms-Regular")
        privacyPolicyView.heightAnchor.constraint(equalToConstant: (descLabelHeight.width / 260) * 40).isActive = true
        
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

