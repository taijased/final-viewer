//
//  CPopUpTableViewCell.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 27.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//



import UIKit

class CPopUpTableViewCell: UITableViewCell {
    
    
    static let reuseId = "CPopUpTableViewCell"
    
    
    
    
    weak var viewModel: CPopUpTableViewCellVMType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            headerLabel.text = viewModel.label
            cloudLogo.image = UIImage(named: viewModel.iconName)
            
        }
    }
    

    fileprivate let cloudLogo: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    fileprivate let headerLabel: UILabel = {
        let label = UILabel.H4.medium
        label.text = "Select files from"
        label.font = UIFont.getTTNormsFont(type: .medium, size: 16)
        label.textAlignment = .left
        return label
    }()

    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        
        
        
        addSubview(cloudLogo)
        cloudLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22).isActive = true
        cloudLogo.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cloudLogo.heightAnchor.constraint(equalToConstant: 22).isActive = true
        cloudLogo.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        
        addSubview(headerLabel)
        headerLabel.leadingAnchor.constraint(equalTo: cloudLogo.trailingAnchor, constant: 12).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    
        
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
