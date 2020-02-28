//
//  SelectCloudTableViewVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit




protocol SelectCloudTableViewVMType {
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func numberOfRows() -> Int
    func numberOfRowsInSection() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SelectCloudTableViewCellVMType?
    var onReloadData: (() -> Void)? { get set }
    func selectItem(atIndexPath indexPath: IndexPath)
    func viewModelForSelectedRow() -> SelectCloudModel?
}

class SelectCloudTableViewVM: SelectCloudTableViewVMType {
    
    private var selectedIndexPath: IndexPath?
    var onReloadData: (() -> Void)?
    
    
    
    var cells: [SelectCloudModel]?
    
    init() {
        
        cells = [
//            SelectCloudModel(type: .dropboxs),
//            SelectCloudModel(type: .yadisk),
//            SelectCloudModel(type: .onedrive),
//            SelectCloudModel(type: .googledisk),
//            SelectCloudModel(type: .icloud),
            SelectCloudModel(type: .systemFiles),
        ]
    }
    
    
    func numberOfRows() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return cells?.count ?? 0
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SelectCloudTableViewCellVMType? {
        guard let cells = cells else { return nil }
        let cell = cells[indexPath.row]
        return SelectCloudTableViewCellVM(cell: cell)
    }
    
    func selectItem(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    
    
    func viewModelForSelectedRow() -> SelectCloudModel? {
        guard let selectedIndexPath = selectedIndexPath, let cells = cells  else { return nil }
        return cells[selectedIndexPath.row]
    }
    
}
