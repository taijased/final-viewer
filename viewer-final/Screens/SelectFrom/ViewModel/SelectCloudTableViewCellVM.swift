//
//  SelectCloudTableViewCellVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit

protocol SelectCloudTableViewCellVMType: class {
    var label: String { get }
    var iconName: String { get }
}



class SelectCloudTableViewCellVM: SelectCloudTableViewCellVMType  {
    
    

    
    
    private var cell: SelectCloudModel
    
    var label: String {
        return cell.label
    }
    var iconName: String {
        return cell.iconName
    }
    
    init(cell: SelectCloudModel) {
        self.cell = cell
    }
}
