//
//  SectionCollectionViewCell.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 17.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//



import UIKit



final class SectionCollectionViewCell3D: UICollectionViewCell {
    
    static let reuseId = "SectionCollectionViewCell3D"
    let tableView: InfoTableView = InfoTableView(frame: .zero, style: .plain, tableType: .threeD)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    fileprivate func setupUI() {
        addSubview(tableView)
        tableView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

final class SectionCollectionViewCellAR: UICollectionViewCell {
    
    static let reuseId = "SectionCollectionViewCellAR"
    
    
    let tableView: InfoTableView = InfoTableView(frame: .zero, style: .plain, tableType: .ar)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    fileprivate func setupUI() {
        addSubview(tableView)
        tableView.fillSuperview()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

