//
//  TrueFormats.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 28.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation


struct TrueFormats{
    private let parseText: String = """
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
    DAE
    Collada
    DXF
    ENFF
    FBX
    glTF
    GLB
    IFC-STEP
    IRR
    IRRMESH
    LWO
    LWS
    LXO
    MD2
    MD3
    MD5
    MDC
    MDL
    MESH
    MESH.XML
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
    
    
    
    func isSupportedFormats(_ value: String) -> Bool {
        
        for item in self.parseText.split(separator: "\n") {
            if item.uppercased() == value.uppercased() {
                return true
            }
        }
        return false
    }
}
