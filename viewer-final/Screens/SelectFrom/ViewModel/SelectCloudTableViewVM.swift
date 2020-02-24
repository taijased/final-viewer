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
}

class SelectCloudTableViewVM: SelectCloudTableViewVMType {
   
    
    var onReloadData: (() -> Void)?
    
    
    
    var cells: [SelectCloudModel]?
    
    init() {
        
        cells = [
            SelectCloudModel(label: "Dropbox", iconName: "db-logo"),
            SelectCloudModel(label: "Yandex.Disk", iconName: "yd-logo"),
            SelectCloudModel(label: "OneDrive", iconName: "od-logo"),
            SelectCloudModel(label: "Google Drive", iconName: "gd-logo"),
            SelectCloudModel(label: "iCloud", iconName: "i-logo"),
            SelectCloudModel(label: "Choose from file", iconName: "files-logo"),
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
    
}
