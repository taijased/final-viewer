//
//  CloudTableViewCellVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 25.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import Foundation


protocol CloudTableViewCellVMType: class {
    var name: String { get }
    var tableView: FilesTableView { get }
}


class CloudTableViewCellVM: CloudTableViewCellVMType {
    var name: String
    var tableView: FilesTableView
    
    
    init(name: String, cells: [TagModel]) {
        self.name = name
        tableView = FilesTableView()
    }
    
}
