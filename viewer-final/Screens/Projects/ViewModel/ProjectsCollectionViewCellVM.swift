//
//  ProjectsCollectionViewCellVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 19.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit

protocol ProjectsCollectionViewCellVMType: class {
    var indexPath: IndexPath { get }
    var object: ProjectFileModel { get }
}



class ProjectsCollectionViewCellVM: ProjectsCollectionViewCellVMType {
    var indexPath: IndexPath
    let object: ProjectFileModel
    
    init(cell: ProjectFileModel, indexPath: IndexPath) {
        self.object = cell
        self.indexPath = indexPath
    }
}
