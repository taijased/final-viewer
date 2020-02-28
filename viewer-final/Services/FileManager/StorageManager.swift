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













enum StorageManagerNotify {
    case fileExist
    case success
    case error
    func getDescription() -> String {
        switch self {
        case .fileExist:
            return "Already exists! Do nothing"
        case .success:
            return "Copied file!"
        case .error:
            return "Error"
        }
    }
}



class StorageManager {
    
    static func create(_ url: URL, completion: @escaping (StorageManagerNotify) -> Void) {
        guard  TrueFormats().isSupportedFormats(url.pathExtension) else { return }
        
        let item = ProjectFileModel(id: UUID().uuidString, name: url.lastPathComponent, path: url.absoluteString)
        let exist = realm.object(ofType: ProjectFileModel.self, forPrimaryKey: item.id) == nil
        let comperePath = realm.objects(ProjectFileModel.self).filter { $0.path == item.path }.first == nil

        
        if exist && comperePath {
           try! realm.write {
                realm.add(item)
                completion(.success)
            }
        } else {
            completion(.fileExist)
        }
        
        completion(.fileExist)
    }
    
    
    
    
    static func clearData() {
       try! realm.write {
           realm.deleteAll()
           print(#function)
       }
    }
       
}
