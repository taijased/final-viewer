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

class StorageManager {
    
    
    
    static func create(_ url: URL, completion: @escaping () -> Void) {
       
        let item = ProjectFileModel(id: UUID().uuidString, name: url.lastPathComponent, path: url.absoluteString)
        let exist = realm.object(ofType: ProjectFileModel.self, forPrimaryKey: item.id) == nil
        let comperePath = realm.objects(ProjectFileModel.self).filter { $0.path == item.path }.first == nil
        
        if exist && comperePath {
           try! realm.write {
                realm.add(item)
                completion()
            }
        }
        
        completion()
    }
    
    
    
    
    static func clearData() {
       try! realm.write {
           realm.deleteAll()
           print(#function)
       }
    }
       
}
