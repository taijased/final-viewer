//
//  InfoTableViewCellVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 17.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit

protocol InfoTableViewCellVMType: class {
    var type: InformationCellType { get set}
}

class InfoTableViewCellVM: InfoTableViewCellVMType  {
    var type: InformationCellType
    
    
    init(type: InformationCellType) {
        self.type = type
    }
}
