//
//  ProjectsViewModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 19.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation


protocol ProjectsViewModelType {
      var collectionView: ProjectsCollectionView { get }
}

class ProjectsViewModel: ProjectsViewModelType {
    var collectionView: ProjectsCollectionView
    
    init() {
         collectionView = ProjectsCollectionView()
    }
}

