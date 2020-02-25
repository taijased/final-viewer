//
//  FormatListTableViewVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit


protocol FormatListTableViewVMType {
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func numberOfRows() -> Int
    func numberOfRowsInSection() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FormatListTableViewCellVMType?
    var onReloadData: (() -> Void)? { get set }
}

class FormatListTableViewVM: FormatListTableViewVMType {
    
    
    var onReloadData: (() -> Void)?
    var cells: [FormatListModel]?
    
    let parseText: String = """
    3D
    3DS
    3MF
    AC
    AC3D
    ACC
    AMF
    AMJ
    ASE
    ASK
    B3D
    BLEND
    BVH
    COB
    DAE/Collada
    DXF
    ENFF
    FBX (FBX SDK 2012 fully supported, later versions are partially supported)
    glTF 1.0 + GLB
    glTF 2.0
    IFC-STEP
    IRR / IRRMESH
    LWO
    LWS
    LXO
    MD2
    MD3
    MD5
    MDC
    MDL
    MESH / MESH.XML
    MOT
    MS3D
    NDO
    NFF
    OBJ
    OFF
    OGEX
    PLY
    PMX
    PRJ
    Q3O
    Q3S
    RAW
    SCN
    SIB
    SMD
    STL
    TER
    UC
    VTA
    X
    X3D
    XGL
    ZGL
    """
    
    init() {
        cells = getCells()
    }
    
    fileprivate func getCells() -> [FormatListModel] {
        var result: [FormatListModel] = []
        for (_, item) in self.parseText.split(separator: "\n").enumerated() {
            result.append(FormatListModel(label: String(item)))
        }
        return result
    }
    
    
    func numberOfRows() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return cells?.count ?? 0
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 25.0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FormatListTableViewCellVMType? {
        guard let cells = cells else { return nil }
        let cell = cells[indexPath.row]
        return FormatListTableViewCellVM(cell: cell)
    }
    
}
