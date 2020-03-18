//
//  ProjectsCollectionHeaderViewCell.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 18.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit




class ProjectsCollectionHeaderViewCell: UICollectionReusableView {
    
    static let reuseId = "ProjectsCollectionHeaderViewCell"
    
    lazy fileprivate var headerLabel: UILabel = {
        let label = UILabel.H1.bold
        label.textColor = UIColor.Black.primary
        label.text = "Projects.title".localized
        label.font = UIFont.getTTNormsFont(type: .bold, size: 32)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .clear
        
        addSubview(headerLabel)
        headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            if self.traitCollection.userInterfaceStyle == .light {
                self.headerLabel.textColor = UIColor.Black.primary
            } else {
                self.headerLabel.textColor = .white
            }
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

