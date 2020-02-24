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
}



class ProjectsCollectionViewCellVM: ProjectsCollectionViewCellVMType {
    
    private var profile: AppleSong

    var label: String {
        return profile.name
    }

    var imageURL: String {
        return profile.artworkUrl100
    }
    
    
    init(cell: AppleSong) {
        self.profile = cell
    }
}
