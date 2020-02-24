//
//  SelectCloudVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

protocol SelectCloudVMType {
    var tableView: SelectCloudTableView { get }
}

struct SelectCloudVM: SelectCloudVMType {
    
    var tableView: SelectCloudTableView
    
    init() {
        tableView = SelectCloudTableView()
    }
}
