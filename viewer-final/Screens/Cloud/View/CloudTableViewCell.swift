//
//  CloudTableViewCell.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 25.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit


class CloudTableViewCell: UITableViewCell {
    
    
    static let reuseId: String = "CloudTableViewCell"
    let tableView = FilesTableView()
    
    
    
    weak var viewModel: CloudTableViewCellVMType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            tableView.viewModel = viewModel.tableView.viewModel
            tableView.reloadData()
            tableView.viewModel?.onReloadData = {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    fileprivate func setupUI() {
        addSubview(tableView)
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
