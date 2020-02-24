//
//  ProjectsCollectionViewVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 19.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit


protocol ProjectsCollectionViewVMType {
    
    var minimumInteritemSpacingForSectionAt: CGFloat { get }
    var minimumLineSpacingForSectionAt: CGFloat { get }
    func sizeForItemAt() -> CGSize
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ProjectsCollectionViewCellVMType?
    func viewModelForSelectedRow() -> AppleSong?
    func selectItem(atIndexPath indexPath: IndexPath)
    var onReloadData: (() -> Void)? { get set }
}





class ProjectsCollectionViewVM: ProjectsCollectionViewVMType {
    
    var onReloadData: (() -> Void)?
    private var dataFetcherService = DataFetcherService()
    private var selectedIndexPath: IndexPath?
    
    var minimumInteritemSpacingForSectionAt: CGFloat = 20.0
    var minimumLineSpacingForSectionAt: CGFloat = 40.0
    
    var cells: [AppleSong]?
    
    init() {
        self.dataFetcherService.fetchRSSAppleMusic { [weak self ](feed) in
            self?.cells = feed?.feed.results ?? nil
            self?.onReloadData?()
        }
    }
    
    
    func sizeForItemAt() -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width - 60) * 0.5
        let height: CGFloat = 160
        
        return CGSize(width: width, height: height)
    }
    
    
    
    func numberOfRows() -> Int {
        return cells?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ProjectsCollectionViewCellVMType? {
        guard let cells = cells else { return nil }
        let cell = cells[indexPath.row]
        return ProjectsCollectionViewCellVM(cell: cell)
    }
    
    func viewModelForSelectedRow() -> AppleSong? {
        guard let selectedIndexPath = selectedIndexPath, let cells = cells else { return nil }
        return cells[selectedIndexPath.row]
    }
    
    
    func selectItem(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    
    
}
