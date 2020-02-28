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
    
    
    init() {
        tableView = SelectCloudTableView()
        tableView.selectDelegate = self
    }
    
    func didPickDocumentsAt(urls: [URL]) {
        
        guard let selectedFileURL = urls.first else { return }
        
        StorageManager.create(selectedFileURL) { [weak self] success in
            self?.onNavigate?(.errorFormat(msg: success.getDescription()))
        }
        
    }
}


//MARK: - SelectCloudDelegate select item from Cloud type

extension SelectCloudVM: SelectCloudDelegate {
    func openSupportedFormats() {
//        self.onNavigate()
        
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
