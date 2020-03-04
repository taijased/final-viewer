//
//  ProjectsCollectionViewVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 19.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit
import RealmSwift

protocol ProjectsCollectionViewVMType {
    
    var minimumInteritemSpacingForSectionAt: CGFloat { get }
    var minimumLineSpacingForSectionAt: CGFloat { get }
    func sizeForItemAt() -> CGSize
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ProjectsCollectionViewCellVMType?
    func viewModelForSelectedRow() -> ProjectFileModel?
    func selectItem(atIndexPath indexPath: IndexPath)
    var onReloadData: (() -> Void)? { get set }
    func isEmpty() -> Bool
}





class ProjectsCollectionViewVM: ProjectsCollectionViewVMType {
    
    var onReloadData: (() -> Void)?
    private var dataFetcherService = DataFetcherService()
    private var selectedIndexPath: IndexPath?
    
    var minimumInteritemSpacingForSectionAt: CGFloat = 20.0
    var minimumLineSpacingForSectionAt: CGFloat = 20.0
    
    //    var cells: [ProjectFileModel]?
    
    var cells: Results<ProjectFileModel>?
    
    let fileFetcher = LocalFileFetcher()
    
    
    init() {
        fetchFromRealm()
    }
    
    fileprivate func fetchFromRealm() {
        self.cells = realm.objects(ProjectFileModel.self)
    }
    
    
    func sizeForItemAt() -> CGSize {
        
        if UIDevice.current.model == "iPhone" {
            let width: CGFloat = (UIScreen.main.bounds.width - 60) * 0.5
            let height: CGFloat = 160
            return CGSize(width: width, height: height)
        } else {
            if UIDevice.current.orientation == .portrait || UIDevice.current.orientation == .portraitUpsideDown {
//                let width: CGFloat = (UIScreen.main.bounds.width - 120) / 4
                let height: CGFloat = 160
                return CGSize(width: 180, height: height)
            } else {
//                let width: CGFloat = (UIScreen.main.bounds.width - 160) / 6
                let height: CGFloat = 160
                return CGSize(width: 188, height: height)
            }
            
            
            
        }
    }
    
    
    func isEmpty() -> Bool {
        return cells?.isEmpty ?? true
    }
    
    func numberOfRows() -> Int {
        return cells?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ProjectsCollectionViewCellVMType? {
        guard let cells = cells else { return nil }
        let cell = cells[indexPath.row]
        return ProjectsCollectionViewCellVM(cell: cell, indexPath: indexPath)
    }
    
    func viewModelForSelectedRow() -> ProjectFileModel? {
        guard let selectedIndexPath = selectedIndexPath, let cells = cells else { return nil }
        return cells[selectedIndexPath.row]
    }
    
    
    func selectItem(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    
    
}
