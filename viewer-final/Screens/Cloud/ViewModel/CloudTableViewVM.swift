//
//  CloudTableViewVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 25.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit


protocol CloudTableViewVMType {
    var heightForHeaderInSection: CGFloat { get set }
    func setHeightForRowAt(_ value: CGFloat)
    func heightForRowAt(_ indexPath: IndexPath) -> CGFloat
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CloudTableViewCellVMType
    var onReloadData: (() -> Void)? { get set }
    var onDeleteRows: (([IndexPath]) -> Void)? { get set }
    var onInsertRows: (([IndexPath]) -> Void)? { get set }
    func isExpanded(_ section: Int) -> Bool
    func expandSection(_ section: Int)
    func generateSectionView(_ section: Int) -> CloudTableViewSectionHeader
    var headerView: CloudTableHeaderView { get set }
    
    var onNavigate: ((CloudNavigation) -> Void)? { get set }
    
}


class CloudTableViewVM: CloudTableViewVMType {
    
    var onNavigate: ((CloudNavigation) -> Void)?
    
    var heightForHeaderInSection: CGFloat = 36
    var heightRow: CGFloat = 0
    
    
    
    var cells = [
        
        
        
        ExpandableNames(isExpanded: false, cellVM: CloudTableViewCellVM(name: "Длина (м)", cells: [
            TagModel(label: "6,60", status: false),
            TagModel(label: "2,95", status: false),
            TagModel(label: "8,84", status: false),
        ])),
        ExpandableNames(isExpanded: true, cellVM: CloudTableViewCellVM(name: "Ширина (см)", cells: [
            TagModel(label: "68,58", status: false),
            TagModel(label: "5", status: false),
        ])),
        ExpandableNames(isExpanded: false, cellVM: CloudTableViewCellVM(name: "Покрытие", cells: [
            TagModel(label: "флизелин с акриловым напылением", status: false),
            TagModel(label: "винил горячего тиснения", status: false),
        ])),
        ExpandableNames(isExpanded: false, cellVM: CloudTableViewCellVM(name: "Основа", cells: [
            TagModel(label: "бумага", status: false),
            TagModel(label: "флизелин", status: false)
        ])),
        ExpandableNames(isExpanded: true, cellVM: CloudTableViewCellVM(name: "Бренд", cells: [
            TagModel(label: "Sangiorgio", status: false),

            TagModel(label: "SK Filson", status: false),
        ])),
        ExpandableNames(isExpanded: false, cellVM: CloudTableViewCellVM(name: "Страна", cells: [
            TagModel(label: "Германия", status: false),

            TagModel(label: "Турция", status: false),
        ])),
        
        
        
    ]
    
    
    
    var onReloadData: (() -> Void)?
    var onDeleteRows: (([IndexPath]) -> Void)?
    var onInsertRows: (([IndexPath]) -> Void)?
    var headerView: CloudTableHeaderView
    
    
    init() {
        headerView = CloudTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CloudTableHeaderView.height))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.cloudLogoTapped(recognzier:)))
        headerView.addGestureRecognizer(tapGestureRecognizer)
        
        
        self.onReloadData?()
    }
    

    @objc func cloudLogoTapped(recognzier: UITapGestureRecognizer) {
        onNavigate?(.selectCloud)
    }
    
    
    func isExpanded(_ section: Int) -> Bool {
        return cells[section].isExpanded
    }
    
    func expandSection(_ section: Int) {
        
        
        
        let indexPaths = [IndexPath(row: 0, section: section)]
        
        cells[section].isExpanded = !cells[section].isExpanded
        
        if !cells[section].isExpanded {
            self.onDeleteRows?(indexPaths)
            
        } else {
            self.onInsertRows?(indexPaths)
        }
        
    }
    
    func setHeightForRowAt(_ value: CGFloat) {
        self.heightRow = value
    }
    
    func heightForRowAt(_ indexPath: IndexPath) -> CGFloat {
        return self.heightRow
    }
    
    func numberOfSections() -> Int {
        return cells.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        
        if !cells[section].isExpanded {
            return 0
        }
        return 1
    }
    
    

    func cellViewModel(forIndexPath indexPath: IndexPath) -> CloudTableViewCellVMType {
          cells[indexPath.section].cellVM
    }
    
    
    func generateSectionView(_ section: Int) -> CloudTableViewSectionHeader {
        let sectionView = CloudTableViewSectionHeader()
        sectionView.expandButton.tag = section
        sectionView.updateButton(expandStatus: isExpanded(section))
        sectionView.label.text = cells[section].cellVM.name
        return sectionView
    }
    
    
}



struct TagModel {
    let label: String
    var status: Bool

}
