//
//  FormatListVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

protocol FormatListVMType {
    var tableView: FormatListTableView { get }
}

struct FormatListVM: FormatListVMType {
    
    var tableView: FormatListTableView
    
    init() {
        tableView = FormatListTableView()
    }
}
