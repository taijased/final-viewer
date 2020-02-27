//
//  CloudTableViewSectionHeader.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 25.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit


class CloudTableViewSectionHeader: UIView {
    
    
    let label: UILabel = {
        let label = UILabel.H3.medium
        label.textAlignment = .left
        label.text = "Folder Name"
        return label
    }()
    
    fileprivate let sectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    
    fileprivate let folderView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "folder-view")
        return view
    }()
    
    
    let expandButton: UIButton = {
        let button =  UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        
        backgroundColor = .white
        addSubview(sectionView)
        sectionView.fillSuperview()
        
        
        sectionView.addSubview(folderView)
        folderView.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 22).isActive = true
        folderView.centerYAnchor.constraint(equalTo: sectionView.centerYAnchor).isActive = true
        folderView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        folderView.heightAnchor.constraint(equalToConstant: 22).isActive = true

        sectionView.addSubview(label)
        label.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor, constant: -20).isActive = true
        label.leadingAnchor.constraint(equalTo: folderView.trailingAnchor, constant: 10).isActive = true
        label.centerYAnchor.constraint(equalTo: sectionView.centerYAnchor).isActive = true
        
        
        
        addSubview(expandButton)
        expandButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        expandButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        expandButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        expandButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func updateButton(expandStatus: Bool) {
        if expandStatus {
            UIView.animate(withDuration: 0.3) {
                self.expandButton.setImage(UIImage(named: "arrow-down"), for: .normal)
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.expandButton.setImage(UIImage(named: "arrow-top"), for: .normal)
            }
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

