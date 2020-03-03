//
//  FormatListTableViewCell.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit

class FormatListTableViewCell: UITableViewCell {
    
    
    static let reuseId = "FormatListTableViewCell"
    
    
    weak var viewModel: FormatListTableViewCellVMType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            headerLabel.text = viewModel.label
        }
    }
    
    
    
    
    fileprivate let headerLabel: UILabel = {
        let label = UILabel.H4.medium
        label.text = "3DS"
        label.font = UIFont.getTTNormsFont(type: .medium, size: 16)
        label.textAlignment = .left
        return label
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        
        addSubview(headerLabel)
        headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if traitCollection.userInterfaceStyle == .light {
            headerLabel.textColor = UIColor.Black.primary
        } else {
            headerLabel.textColor = .white
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
