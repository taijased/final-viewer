//
//  InfoTableViewCell.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 17.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit


protocol InfoTableViewCellSizeDelegate: class {
    func updateHeight()
}



class InfoTableViewCell: UITableViewCell {
    
    
    static let reuseId = "InfoTableViewCell"
    
    weak var delegate: InfoTableViewCellSizeDelegate?
    
    
    lazy fileprivate var headerLabel: UILabel = {
        let label = UILabel.H1.bold
        label.textColor = UIColor.Primary.primary
        label.font = UIFont.getTTNormsFont(type: .bold, size: 32)
        label.textColor = UIColor.Primary.primary
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy fileprivate var descriptionLabel: UILabel = {
        let label = UILabel.H4.medium
        label.textColor = UIColor.Black.primary
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy fileprivate var iconImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var viewModel: InfoTableViewCellVMType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            self.viewModel = viewModel
            if viewModel.type.label != nil {
                initLabel()
            } else if viewModel.type.informationIcons != nil {
                initIcons()
            }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        DispatchQueue.main.async { [weak self] in
            if self?.traitCollection.userInterfaceStyle == .light {
                self?.descriptionLabel.textColor = UIColor.Black.primary
                guard let imageName = self?.viewModel?.type.informationIcons?.getImageLight() else { return }
                self?.iconImage.image = UIImage(named: imageName)
                
            } else {
                
                self?.descriptionLabel.textColor = .white
                guard let imageName = self?.viewModel?.type.informationIcons?.getImageDark() else { return }
                self?.iconImage.image = UIImage(named: imageName)
            }
        }
        
    }
    
    
    fileprivate func setupUI() {
        self.addSubview(self.headerLabel)
        self.headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22).isActive = true
        self.headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -22).isActive = true
        self.headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 22).isActive = true
        self.headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -11).isActive = true
        
        
        self.addSubview(self.iconImage)
        self.iconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22).isActive = true
        self.iconImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.iconImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.topAnchor.constraint(equalTo: self.iconImage.bottomAnchor, constant: 8).isActive = true
        self.descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        self.descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22).isActive = true
        self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -22).isActive = true
        
    }
    
    
    fileprivate func initLabel() {
        guard let label = viewModel?.type.label else { return }
        headerLabel.text = label
        estimateCellSize(views: [self.headerLabel])
    }
    
    
    
    
    fileprivate func initIcons() {
        
        guard
            let viewModel = viewModel,
            
            let imageName = self.traitCollection.userInterfaceStyle == .light ? viewModel.type.informationIcons?.getImageLight() :  viewModel.type.informationIcons?.getImageDark() ,
            let description = self.viewModel?.type.informationIcons?.getDescriptionType(viewModel.type.tableType)
            else { return }
        
        self.iconImage.image = UIImage(named: imageName)
        self.descriptionLabel.text = description
        self.estimateCellSize(views: [self.iconImage, self.descriptionLabel])
    }
    
    
    fileprivate func estimateCellSize(views: [UIView]) {
        
        
        var estimateHeight: CGFloat = 0
        let size = CGSize(width: frame.width, height: .infinity)
        for view in views {
            let estimatedSize = view.sizeThatFits(size)
            view.constraints.forEach { (constraint) in
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                    estimateHeight += constraint.constant
                }
            }
        }
        self.frame.size.height = estimateHeight
        self.delegate?.updateHeight()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
    }
    
}

