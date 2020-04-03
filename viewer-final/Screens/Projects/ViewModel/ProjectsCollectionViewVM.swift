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
    func sizeForItemAt(_ size: CGSize) -> CGSize
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
    
    var minimumInteritemSpacingForSectionAt: CGFloat = 16.0
    var minimumLineSpacingForSectionAt: CGFloat = 20.0
    
    //    var cells: [ProjectFileModel]?
    
    var cells: Results<ProjectFileModel>?
    
    let fileFetcher: LocalFileFetcher
    
    
    init(fileFetcher: LocalFileFetcher) {
        self.fileFetcher = fileFetcher
        fetchFromRealm()
    }
    
    fileprivate func fetchFromRealm() {
        
        if realm.objects(FirstTimeLauncher.self).count == 0 {
            fileFetcher.initDefaultFiles { [weak self] in
                self?.cells = realm.objects(ProjectFileModel.self)
                StorageManager.firstTimeLauncher {}
            }
            
        } else {
            self.cells = realm.objects(ProjectFileModel.self)
        }
        onReloadData?()
    }
    
    
    func sizeForItemAt(_ size: CGSize) -> CGSize {
        if UIDevice.current.model == "iPhone" {
            let width: CGFloat = (UIScreen.main.bounds.width - 60) * 0.5
            let height: CGFloat = 160
            let size = CGSize(width: width, height: height)
            return size
        } else {
            if UIDevice.current.orientation == .portrait || UIDevice.current.orientation == .portraitUpsideDown {
                let width: CGFloat = (UIScreen.main.bounds.width - 16 * 5) / 4
                let height: CGFloat = 160
                let size = CGSize(width: width, height: height)
                return size
            } else {
                let width: CGFloat = (UIScreen.main.bounds.width - 16 * 6) / 5
                let height: CGFloat = 160
                let size = CGSize(width: width, height: height)
                return size
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
