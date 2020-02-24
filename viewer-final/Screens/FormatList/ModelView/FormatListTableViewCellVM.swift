//
//  FormatListTableViewCellVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit

protocol FormatListTableViewCellVMType: class {
    var label: String { get }
    
}

class FormatListTableViewCellVM: FormatListTableViewCellVMType  {
    
    
    private var cell: FormatListModel
    
    var label: String {
        return cell.label
    }

    init(cell: FormatListModel) {
        self.cell = cell
    }
}
