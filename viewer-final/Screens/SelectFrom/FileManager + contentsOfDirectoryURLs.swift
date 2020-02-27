//
//  FileManager + contentsOfDirectoryURLs.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 26.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation

//MARK: - Extension for get contents of directory
extension FileManager {
    func contentsOfDirectoryURLs(for directory: FileManager.SearchPathDirectory, skipsHiddenFiles: Bool = true ) -> [URL]? {
        let documentsURL = urls(for: directory, in: .userDomainMask)[0]
        let fileURLs = try? contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: skipsHiddenFiles ? .skipsHiddenFiles : [] )
        return fileURLs
    }
}
