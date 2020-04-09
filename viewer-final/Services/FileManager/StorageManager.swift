//
//  StorageManager.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 28.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation
import RealmSwift

let realm = try! Realm()







protocol RealmGRUDProtocol {
    associatedtype Input
    associatedtype Output
    static func create(object: Input, completion: @escaping () -> Void)
    static func read(id: String, completion: @escaping (Output?) -> Void)
    static func update(object: Output, completion: @escaping () -> Void)
    static func delete(id: String, completion: @escaping () -> Void)
}




class StorageManager {
    
    
    static func firstTimeLauncher(completion: @escaping () -> Void) {
        let item = FirstTimeLauncher(id: UUID().uuidString)
        try! realm.write {
            realm.add(item)
            completion()
        }
    }
    
    static func create(id: String, _ url: URL, completion: @escaping () -> Void) {
        
        let item = ProjectFileModel(id: id, path: url)
        let exist = realm.object(ofType: ProjectFileModel.self, forPrimaryKey: item.id) == nil
        let comperePath = realm.objects(ProjectFileModel.self).filter { $0.path == item.path }.first == nil
        
        
        if exist && comperePath {
            try! realm.write {
                realm.add(item)
                completion()
            }
        } else {
            completion()
        }
        
        completion()
    }
    
    static func create(id: String, imagePath: String, _ url: URL, completion: @escaping () -> Void) {
        
        let item = ProjectFileModel(id: id, path: url, imagePath: imagePath)
        let exist = realm.object(ofType: ProjectFileModel.self, forPrimaryKey: item.id) == nil
        let comperePath = realm.objects(ProjectFileModel.self).filter { $0.path == item.path }.first == nil
        
        
        if exist && comperePath {
            try! realm.write {
                realm.add(item)
                completion()
            }
        } else {
            completion()
        }
        
        completion()
    }
    
    static func create(id: String, imagePath: String, _ url: URL, shareID: String, completion: @escaping () -> Void) {
        
        let item = ProjectFileModel(object: ProjectFileModel(id: id, path: url, imagePath: imagePath), shareID: shareID)
        
        let exist = realm.object(ofType: ProjectFileModel.self, forPrimaryKey: item.id) == nil
        let comperePath = realm.objects(ProjectFileModel.self).filter { $0.path == item.path }.first == nil
        
        
        if exist && comperePath {
            try! realm.write {
                realm.add(item)
                completion()
            }
        } else {
            completion()
        }
        
        completion()
    }
    

    
    static func read(id: String, completion: @escaping (ProjectFileModel?) -> Void) {
        guard let item = realm.object(ofType: ProjectFileModel.self, forPrimaryKey: id) else { return }
        completion(item)
    }
    
    
    
    
    static func update(object: ProjectFileModel, completion: @escaping () -> Void) {
        
        guard realm.object(ofType: ProjectFileModel.self, forPrimaryKey: object.id) != nil else { return }
        
        try! realm.write {
            realm.add(object, update: .modified)
            completion()
        }
        completion()
    }
    
    
    
    
    static func delete(id: String, completion: @escaping () -> Void) {
        guard let exist = realm.object(ofType: ProjectFileModel.self, forPrimaryKey: id) else { return }
        try! realm.write {
            realm.delete(exist)
            completion()
        }
    }
    
    
    
    
    
    static func clearData() {
        try! realm.write {
            realm.deleteAll()
            print(#function)
        }
    }
    
}





//MARK: RealmGRUDServiseType

//final class ProjectFileService {





//    static func create(object: Goods, completion: @escaping () -> Void) {
//        print(#function)
//        let exist = realm.object(ofType: FavoriteItem.self, forPrimaryKey: object.id) != nil
//        if exist {
//            completion()
//        } else {
//            try! realm.write {
//                realm.add(FavoriteItem(goods: object))
//                completion()
//            }
//        }
//    }
//
//    static func read(id: String, completion: @escaping (FavoriteItem?) -> Void) {
//        guard let item = realm.object(ofType: Output.self, forPrimaryKey: id) else { return }
//        completion(item)
//    }
//
//    static func update(object: FavoriteItem, completion: @escaping () -> Void) {
//        print(#function)
//        completion()
//    }
//
//    static func delete(id: String, completion: @escaping () -> Void) {
//
//        guard let favoriteItem = realm.object(ofType: Output.self, forPrimaryKey: id) else { return }
//        try! realm.write {
//            realm.delete(favoriteItem)
//            completion()
//        }
//    }


//}
