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
    
    
    lazy fileprivate var projectsPath: URL = {
        let fileManager = FileManager.default
        let documentsURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsURL.appendingPathComponent("arqprojects")
    }()
    
    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
        self.initARQProjectDirectory()
    }
    
    
    fileprivate func initARQProjectDirectory() {
        
        
        if !projectsPath.hasDirectoryPath {
            do {
                try fileManager.createDirectory(atPath: projectsPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                NSLog("Unable to create directory \(error.debugDescription)")
            }
        }
        
        
        do {
            let fileUrls = try fileManager.contentsOfDirectory(at: projectsPath.appendingPathComponent("A5631D9E-ACEF-4E17-83DC-51195C76499B"), includingPropertiesForKeys: nil)
            print("--------------ARQprojects Files--------------")
            print(fileUrls)
            print("-------------------------------")
        } catch {
            print("Error while enumerating files \(projectsPath.path): \(error.localizedDescription)")
        }

    }
    
    

    func initDefaultFiles(completion: @escaping() -> Void) {
        
        
        let url = Bundle.main.resourceURL!
        do {
            let urls = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys:[], options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
            
            
            
            var index: Int = 1
            urls.forEach { path in
                
        
                
                
                if path.pathExtension.lowercased() == "fbx" {
                    
                    
                    guard TrueFormats().isSupportedFormats(path.pathExtension) else { return }
                    let guid = UUID().uuidString
                    let sandboxFolderURL = projectsPath.appendingPathComponent(guid)
                    do {
                        
                        
                        try fileManager.createDirectory(atPath: sandboxFolderURL.path, withIntermediateDirectories: true, attributes: nil)
                        try fileManager.copyItem(at: path, to: sandboxFolderURL.appendingPathComponent(path.lastPathComponent))


                        

                        let darkPath = path.deletingLastPathComponent().appendingPathComponent("dark-\(index).png")
                        try fileManager.copyItem(at: darkPath, to: sandboxFolderURL.appendingPathComponent("dark.png"))

                        let lightPath = path.deletingLastPathComponent().appendingPathComponent("light-\(index).png")
                        try fileManager.copyItem(at: lightPath, to: sandboxFolderURL.appendingPathComponent("light.png"))




                        StorageManager.create(id: guid, path) {}
                        index += 1
                    }
                    catch let error as NSError  {
                        self.removeFolder(guid)
                        print(error)
                    }
                }
                
            }
            
        } catch {
            print(error)
        }
        completion()
    }
    
    
    
    func copyFile(_ url: URL?, completion: @escaping(FileManagerNotify) -> Void) {
        
        
        guard let selectedFileURL = url,  TrueFormats().isSupportedFormats(selectedFileURL.pathExtension) else { return }
        
        let guid = UUID().uuidString
        let sandboxFolderURL = projectsPath.appendingPathComponent(guid)
        
        
        
        
        if checkExistSelectFile(selectedFileURL.lastPathComponent) {
            completion(.fileExist)
        } else {
            
            do {
                
                try fileManager.createDirectory(atPath: sandboxFolderURL.path, withIntermediateDirectories: true, attributes: nil)
                try fileManager.copyItem(at: selectedFileURL, to: sandboxFolderURL.appendingPathComponent(selectedFileURL.lastPathComponent))
                
                StorageManager.create(id: guid, selectedFileURL) {
                    completion(.success)
                }
                
            }
            catch let error as NSError  {
                self.removeFolder(guid)
                completion(.error)
                print(error)
            }
        }
    }
    
    
    fileprivate func checkExistSelectFile(_ lastPathComponent: String) -> Bool {
        
        guard let fileUrls = try? fileManager.contentsOfDirectory(at: projectsPath, includingPropertiesForKeys: nil) else { return false }

        for file in fileUrls {
            
            if file.appendingPathComponent(lastPathComponent).checkFileExist() {
                return true
            }
        }

        return false
        
    }
    
    
    func removeFolder(_ guid: String) {
        
        let directoryPath = projectsPath.appendingPathComponent(guid)
        if directoryPath.hasDirectoryPath {
            do {
                try fileManager.removeItem(at: directoryPath)
                print(#function)
            } catch let error as NSError {
                print("Unable to delete directory \(error.debugDescription)")
            }
        }
        
    }
    
}





extension URL    {
    func checkFileExist() -> Bool {
        let path = self.path
        if (FileManager.default.fileExists(atPath: path))   {
            return true
        }else        {
            return false
        }
    }
}




