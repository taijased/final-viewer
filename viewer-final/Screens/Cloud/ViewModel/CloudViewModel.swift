//
//  CloudViewModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 25.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation


protocol CloudViewModelType {
    var tableView: CloudTableView { get set }
}




class CloudViewModel: CloudViewModelType {
    
    var tableView: CloudTableView
    
    init() {
        tableView = CloudTableView()
        tableView.layer.cornerRadius = 10
    }
}


