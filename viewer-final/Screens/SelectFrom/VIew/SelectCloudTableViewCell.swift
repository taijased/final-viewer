//
//  SelectCloudTableViewCell.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

//protocol SelectCloudTableViewCellDelegate: class {
//    func clickLink()
//}

class SelectCloudTableViewCell: UITableViewCell {
    
//    weak var delegate: SelectCloudTableViewCellDelegate?
    static let reuseId = "SelectCloudTableViewCell"
    
    
    weak var viewModel: SelectCloudTableViewCellVMType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            headerLabel.text = viewModel.label
            cloudLogo.image = UIImage(named: viewModel.iconName)
//            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
//            headerLabel.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    
    fileprivate let cloudLogoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.shadowRadius = 4
//        view.layer.shadowOpacity = 1
//        view.layer.shadowOffset = CGSize(width: 0, height: 2)
//        view.layer.cornerRadius = 22.5
//        view.layer.position = view.center
//        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        
        view.layer.cornerRadius = 22
        view.layer.borderWidth = 1
        view.backgroundColor = .clear
        return view
    }()
    
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
        
        
        
        addSubview(cloudLogoView)
        cloudLogoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        cloudLogoView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cloudLogoView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        cloudLogoView.widthAnchor.constraint(equalToConstant: 56).isActive = true
        
        
        cloudLogoView.addSubview(cloudLogo)
        cloudLogo.centerXAnchor.constraint(equalTo: cloudLogoView.centerXAnchor).isActive = true
        cloudLogo.centerYAnchor.constraint(equalTo: cloudLogoView.centerYAnchor).isActive = true
        cloudLogo.heightAnchor.constraint(equalToConstant: 22).isActive = true
        cloudLogo.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        addSubview(headerLabel)
        headerLabel.leadingAnchor.constraint(equalTo: cloudLogoView.trailingAnchor, constant: 12).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        headerLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        
    }
    
    
    
//    @objc private func close() {
//        self.delegate?.clickLink()
//    }
//
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        selectionStyle = .none
        if traitCollection.userInterfaceStyle == .light {
            headerLabel.textColor = UIColor.Black.primary
            cloudLogoView.layer.borderColor = UIColor.Gray.primaryLight.cgColor
            cloudLogoView.backgroundColor = .white

        } else {
            headerLabel.textColor = .white
            cloudLogoView.layer.borderColor = UIColor.clear.cgColor
            cloudLogoView.backgroundColor = UIColor.Black.gray
        }
        
 
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
