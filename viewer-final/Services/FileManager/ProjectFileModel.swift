//
//  ProjectFileModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 28.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import RealmSwift


class FirstTimeLauncher: Object {
    @objc dynamic var id: String?
    
    convenience init(id: String) {
        self.init()
        self.id = id
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}



class ProjectFileModel: Object {
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var path: String?
    @objc dynamic var imagePath: String?
    @objc dynamic var lastPathComponent: String?
    @objc dynamic var objectRPS: String?
    
    
    convenience init(id: String, path: URL) {
        self.init()
        self.id = id
        self.name = path.lastPathComponent
        self.path = "\(id)/\(path.lastPathComponent)"
        self.imagePath = nil
        self.lastPathComponent = path.lastPathComponent
        self.objectRPS = ""
    }
    
    convenience init(id: String, path: URL, imagePath: String) {
        self.init()
        self.id = id
        self.name = path.lastPathComponent
        self.path = "\(id)/\(path.lastPathComponent)"
        self.imagePath = imagePath
        self.lastPathComponent = path.lastPathComponent
        self.objectRPS = ""
    }
    
    
    convenience init(newValue: String, object: ProjectFileModel) {
        self.init()
        self.id = object.id
        self.name = newValue
        self.path = object.path
        self.imagePath = object.imagePath
        self.lastPathComponent = object.lastPathComponent
        self.lastPathComponent = object.lastPathComponent
        self.objectRPS = object.objectRPS
    }
    
    convenience init(objectRPS: String, object: ProjectFileModel) {
        self.init()
        self.id = object.id
        self.name = object.name
        self.path = object.path
        self.imagePath = object.imagePath
        self.lastPathComponent = object.lastPathComponent
        self.objectRPS = objectRPS
    }
    
    convenience init(object: ProjectFileModel, imagePath: String) {
        self.init()
        self.id = object.id
        self.name = object.name
        self.path = object.path
        self.imagePath = imagePath
        self.lastPathComponent = object.lastPathComponent
        self.objectRPS = object.objectRPS
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
