//
//  ProjectsCollectionViewCellVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 19.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit

protocol ProjectsCollectionViewCellVMType: class {
    var label: String { get }
    var imageURL: String { get }
    var path: String { get }
    var id: String { get }
}



class ProjectsCollectionViewCellVM: ProjectsCollectionViewCellVMType {
    
    private var file: ProjectFileModel

    var id: String {
        return file.id ?? ""
    }
    
    var label: String {
        return file.name ?? ""
    }
    
    var path: String {
        return file.path ?? ""
    }

    var imageURL: String {
        return file.imagePath ?? ""
    }
    
    
    init(cell: ProjectFileModel) {
        self.file = cell
    }
}
