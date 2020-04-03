//
//  ProjectsUploadView.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 31.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit


final class ProjectsUploadView: UIView {

    fileprivate let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.getTTNormsFont(type: .bold, size: 16)
        label.text = "0%"
        return label
    }()
    
//    private var dataFetcherService = DataFetcherService()
//    private var uploadingService = UploadingService()
//
    
    
//
//    let fileFetcher: LocalFileFetcher
//    let projectId: String?
//
//    init(frame: CGRect, fileFetcher: LocalFileFetcher, id: String?) {
//        self.projectId = id
//        self.fileFetcher = fileFetcher
//        super.init(frame: frame)
//        setupUI()
//
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    
    func startUpload(_ progress: Double) {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.label.text = "\(Int(progress * 100))%"
        }
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
