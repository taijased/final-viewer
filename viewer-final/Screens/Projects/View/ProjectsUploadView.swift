//
//  ProjectsUploadView.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 31.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit



protocol ProjectsUploadViewDelegate: class {
    func dissmis(_ guid: String?)
}


final class ProjectsUploadView: UIView {
    
    weak var delegate: ProjectsUploadViewDelegate?

    
    fileprivate let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.getTTNormsFont(type: .bold, size: 16)
        label.text = "0%"
        return label
    }()
    
    private var dataFetcherService = DataFetcherService()
    private var uploadingService = UploadingService()
    
    
    
    
    let fileFetcher: LocalFileFetcher
    let projectId: String?
    
    init(frame: CGRect, fileFetcher: LocalFileFetcher, id: String?) {
        self.projectId = id
        self.fileFetcher = fileFetcher
        super.init(frame: frame)
        setupUI()
       
    }
    

    
    func startUpload() {
        
        guard let id = projectId, let zipFilePath = fileFetcher.getZipFilePath(id: id) else { return }

        
        let zipFile: Data = try! Data(contentsOf: zipFilePath)
        print(zipFile)
        
        
        dataFetcherService.uploadFile(filePath: zipFilePath) { [weak self] (data) in
            self?.delegate?.dissmis(data?.guid)
        }

        dataFetcherService.onProgress = { [weak self] progress in
            UIView.animate(withDuration: 0.25) {
                self?.label.text = "\(Int(progress * 100))%"
            }
        }
        
        
        
        
        
        
        
//        dataFetcherService.uploadFile(fileData: zipFile) { (data) in
//            print(data)
//        }

//        dataFetcherService.share { (data) in
//            print(data)
//        }

    }
    
    fileprivate func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(label)
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
      
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
