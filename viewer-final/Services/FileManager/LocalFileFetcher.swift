//
//  LocalDataFetcher.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 28.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit


class LocalFileFetcher {


    var fileManager: FileManager
    
    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
        
    }
    

    func fetchLocalData(response: @escaping([URL]?) -> Void) {
        guard let files = fileManager.contentsOfDirectoryURLs(for: .documentDirectory) else { response(nil); return}
        let resultFiles = files.filter { String($0.pathExtension) == "fbx" }
        
        response(resultFiles)
    }
}

