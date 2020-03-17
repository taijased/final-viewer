//
//  InfoTableViewVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 17.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//




import UIKit


protocol InfoTableViewVMType {
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func numberOfRows() -> Int
    func numberOfRowsInSection() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> InfoTableViewCellVMType?
    var onReloadData: (() -> Void)? { get set }
}

class InfoTableViewVM: InfoTableViewVMType {
    
    
    var onReloadData: (() -> Void)?
    var cells: [InformationCellType]?
    
    init(_ type: InformationTableType) {
        switch type {
        case .ar:
            initAR()
        case .threeD:
            init3D()
        }
    }
    
    
    fileprivate func initAR() {
        
        cells = [InformationCellType(label: "Info.label-second".localized, type: .ar),
                 InformationCellType(icons: .move, type: .ar),
                 InformationCellType(icons: .zoom, type: .ar),
                 InformationCellType(icons: .rotation, type: .ar),
        ]
        
        


    }
    
    fileprivate func init3D() {

        cells = [InformationCellType(label: "Info.label-first".localized, type: .threeD),
                 InformationCellType(icons: .move, type: .threeD),
                 InformationCellType(icons: .moveCamera, type: .threeD),
                 InformationCellType(icons: .zoom, type: .threeD),
                 InformationCellType(label: "Info.label-second".localized, type: .threeD),
                 InformationCellType(icons: .selected, type: .threeD),
                 InformationCellType(icons: .moveUp, type: .threeD),
                 InformationCellType(icons: .logo, type: .threeD),
        ]
    }
    
    
    func numberOfRows() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return cells?.count ?? 0
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> InfoTableViewCellVMType? {
        guard let cells = cells else { return nil }
        let cell = cells[indexPath.row]
        return InfoTableViewCellVM(type: cell)
    }
    
}
