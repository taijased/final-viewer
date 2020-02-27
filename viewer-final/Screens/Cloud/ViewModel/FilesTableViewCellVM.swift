//
//  FilesTableViewCellVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 25.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//



import UIKit

protocol FilesTableViewCellVMType: class {
    var label: String { get }
    var iconName: String { get }
}



class FilesTableViewCellVM: FilesTableViewCellVMType  {
    

    
    
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
