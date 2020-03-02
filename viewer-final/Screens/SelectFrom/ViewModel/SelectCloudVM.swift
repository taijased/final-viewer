//
//  SelectCloudVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit
import MobileCoreServices




protocol SelectCloudVMType {
    var tableView: SelectCloudTableView { get }
    var onNavigate: ((SelectCloudNavigation) -> Void)? { get set }
    var documentPicker: UIDocumentPickerViewController { get }
    func didPickDocumentsAt(urls: [URL])
}

class SelectCloudVM: SelectCloudVMType {
    
    
    lazy var documentPicker: UIDocumentPickerViewController = {
        let picker =  UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
        picker.allowsMultipleSelection = false
        return picker
    }()
    
    var onNavigate: ((SelectCloudNavigation) -> Void)?
    var tableView: SelectCloudTableView
    
    
    
    fileprivate let localFileFetcher: LocalFileFetcher = LocalFileFetcher()
    
    
    init() {
        tableView = SelectCloudTableView()
        tableView.selectDelegate = self
        
    }
    
    
    
    func didPickDocumentsAt(urls: [URL]) {
        
        localFileFetcher.copyFile(urls.first) { [weak self] notify in
            self?.onNavigate?(.errorFormat(msg: notify.getDescription()))
        }
        
    }
    
    
}


//MARK: - SelectCloudDelegate select item from Cloud type

extension SelectCloudVM: SelectCloudDelegate {
    func openSupportedFormats() {
        self.onNavigate?(.supportedFormats)
    }
    
    func didSelectItemAt(_ item: SelectCloudModel) {
        switch item.type {
            
        case .googledisk:
            print(item.type)
        case .dropboxs:
            print(item.type)
        case .yadisk:
            print(item.type)
        case .onedrive:
            print(item.type)
        case .icloud:
            print(item.type)
        case .systemFiles:
            self.onNavigate?(.documentPicker)
        }
    }
}



extension URL {
    enum Filestatus {
        case isFile
        case isDir
        case isNot
    }
    
    var filestatus: Filestatus {
        get {
            let filestatus: Filestatus
            var isDir: ObjCBool = false
            if FileManager.default.fileExists(atPath: self.path, isDirectory: &isDir) {
                if isDir.boolValue {
                    // file exists and is a directory
                    filestatus = .isDir
                }
                else {
                    // file exists and is not a directory
                    filestatus = .isFile
                }
            }
            else {
                // file does not exist
                filestatus = .isNot
            }
            return filestatus
        }
    }
}
