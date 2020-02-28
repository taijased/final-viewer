//
//  ProjectFileModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 28.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import RealmSwift




class ProjectFileModel: Object {
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var path: String?
    @objc dynamic var imagePath: String?
    @objc dynamic var typeFrom: String?
    
    
    convenience init(id: String, name: String, path: String, imagePath: String, typeFrom: String) {
        self.init()
        self.id = id
        self.name = name
        self.path = path
        self.imagePath = imagePath
        self.typeFrom = typeFrom
    }
    
    convenience init(id: String, name: String, path: String) {
        self.init()
        self.id = id
        self.name = name
        self.path = path
        self.imagePath = nil
        self.typeFrom = nil
    }
    

    
    override class func primaryKey() -> String? {
        return "id"
    }
}
