//
//  CPopUpTableHeaderView.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 27.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//



import UIKit


protocol CPopUpTableHeaderViewDelegate: class {
    func close()
}



class CPopUpTableHeaderView: UIView {
    weak var delegate: CPopUpTableHeaderViewDelegate?
    
    static let height: CGFloat = 50
    
    fileprivate let headerLabel: UILabel = {
        let label = UILabel.H4.medium
        label.text = "Select cloud"
        label.font = UIFont.getTTNormsFont(type: .bold, size: 19)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate let closeButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()
    
    @objc func closeButtonTapped(_ sender: UIButton) {
        sender.flash()
        delegate?.close()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .white
        setupConstrints()
    }
    
    
    fileprivate func setupConstrints() {
        
        
        addSubview(headerLabel)
        headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22).isActive = true
        
        addSubview(closeButton)
        closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22).isActive = true
        closeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
        

    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
