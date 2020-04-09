//
//  LocalDataFetcher.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 28.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit
import Zip



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
    
    func getZipFilePath(id: String) -> URL? {
        do {
            let fileUrls = try fileManager.contentsOfDirectory(at: projectsPath.appendingPathComponent(id), includingPropertiesForKeys: nil)
            return fileUrls.filter { $0.pathExtension.lowercased() == "zip"}.first
        } catch {
            print("Error while get zip file \(projectsPath.path): \(error.localizedDescription)")
            return nil
        }
    }
    
    func addNewZip(_ path: URL, completion: @escaping(URL?) -> Void) {
        
        let guid = UUID().uuidString
        let sandboxFolderURL = projectsPath.appendingPathComponent(guid)
        
        
        do {
            
            //создани папкм
            try fileManager.createDirectory(atPath: sandboxFolderURL.path, withIntermediateDirectories: true, attributes: nil)
            
            //запись архива в папку
            let savedURL = sandboxFolderURL.appendingPathComponent("archive").appendingPathExtension("zip")
            try FileManager.default.moveItem(at: path, to: savedURL)
            
            //unziping
            
            try Zip.unzipFile(savedURL, destination: sandboxFolderURL, overwrite: true, password: nil)
            
            let unzipFiles = try fileManager.contentsOfDirectory(at: projectsPath.appendingPathComponent(guid), includingPropertiesForKeys: nil)
            
            
            
            
            var modelPath: URL? = nil
            
            unzipFiles.forEach { url in
                if TrueFormats().isSupportedFormats(url.pathExtension) {
                    modelPath = url
                }
            }
            
            
            
            if modelPath != nil {
                
                if sandboxFolderURL.appendingPathComponent("light.png").checkFileExist() {
                    
                    StorageManager.create(id: guid, imagePath: sandboxFolderURL.appendingPathComponent("light.png").absoluteString, modelPath!) { }
                } else {
                    StorageManager.create(id: guid, modelPath!) {}
                }
                completion(path)
            } else {
                throw NSError()
            }
            
            
        }
        catch let error as NSError  {
            self.removeFolder(guid)
            completion(nil)
            print(error)
        }
    }
    
    
    fileprivate func createZIP(id: String, archiveName: String = "archive.zip") {
        do {
            let projectPath = projectsPath.appendingPathComponent(id)
            let fileUrls = try fileManager.contentsOfDirectory(at: projectPath, includingPropertiesForKeys: nil)
            let zipFilePath = projectPath.appendingPathComponent(archiveName)
            try Zip.zipFiles(paths: fileUrls, zipFilePath: zipFilePath, password: nil, progress: nil)
            print(zipFilePath)
        } catch  {}
    }
    
    
    
    fileprivate func initARQProjectDirectory() {
        
        
        if !projectsPath.hasDirectoryPath {
            do {
                try fileManager.createDirectory(atPath: projectsPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                NSLog("Unable to create directory \(error.debugDescription)")
            }
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
                        
                        let darkPath = path.deletingLastPathComponent().appendingPathComponent("dark-\(index)").appendingPathExtension("png")
                        try fileManager.copyItem(at: darkPath, to: sandboxFolderURL.appendingPathComponent("dark").appendingPathExtension("png"))
                        
                        let lightPath = path.deletingLastPathComponent().appendingPathComponent("light-\(index)").appendingPathExtension("png")
                        try fileManager.copyItem(at: lightPath, to: sandboxFolderURL.appendingPathComponent("light").appendingPathExtension("png"))
                        
                        
                        
//                        StorageManager.create(id: guid, imagePath: darkPath.absoluteString, path) {
//
//
//                        }
                        
                        //share guid
                                 
                        
                        let shareGuid = String(path.lastPathComponent.split(separator: ".").first!)
                        
                        StorageManager.create(id: guid, imagePath: darkPath.absoluteString, path, shareID: shareGuid) {
                            
                        }

                        
                        
                        
                        self.createZIP(id: guid)
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
                
                createZIP(id: guid)
                
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




