//
//  LoaderViewController.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 03.04.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit

protocol LoaderViewControllerDelegate: class {
    func deinitController()
    func finishUploadingFile(guid: String?)
}


class LoaderViewController: UIViewController {
    
    weak var delegate: LoaderViewControllerDelegate?
    
    
    let projectsUploadView: ProjectsUploadView = ProjectsUploadView()
    fileprivate let localFileFetcher: LocalFileFetcher = LocalFileFetcher()
    fileprivate let dataFetcherService: DataFetcherService = DataFetcherService()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.getTTNormsFont(type: .bold, size: 16)
        label.textAlignment = .center
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.getTTNormsFont(type: .regular, size: 14)
        label.textAlignment = .center
        return label
    }()
    
    init(title: String, description: String) {
        super.init(nibName: nil, bundle: nil)
        self.mainLabel.text = title
        self.descLabel.text = description
        transitioningDelegate = self
        modalPresentationStyle = .custom
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        view.addSubview(descLabel)
        descLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -21).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21).isActive = true
        descLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        view.addSubview(mainLabel)
        mainLabel.bottomAnchor.constraint(equalTo: descLabel.topAnchor, constant: -4).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21).isActive = true
        mainLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        view.addSubview(projectsUploadView)
        projectsUploadView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -61).isActive = true
        projectsUploadView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        projectsUploadView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        projectsUploadView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
    }
    
    func startUpload(guid: String) {
        guard let zipFilePath = self.localFileFetcher.getZipFilePath(id: guid) else { return }
        dataFetcherService.uploadFile(filePath: zipFilePath) { [weak self] (data) in
            self?.dismiss(animated: true, completion: {
                self?.delegate?.finishUploadingFile(guid: data?.guid)
            })
        }
        
        dataFetcherService.onProgress = { [weak self] progress in
            self?.projectsUploadView.startUpload(progress)
        }
    }
    
    func startDownload(guid: String) {
        
        
        dataFetcherService.downloadFile(guid: guid)
        
        dataFetcherService.fileLocation = { [weak self] url in
            self?.delegate?.deinitController()
            self?.dismiss(animated: true, completion: nil)
        }
        
        
        
        
        dataFetcherService.onProgress = { [weak self] progress in
            self?.projectsUploadView.startUpload(progress)
        }
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        DispatchQueue.main.async {
            if self.traitCollection.userInterfaceStyle == .light {
                self.view.backgroundColor = UIColor.Gray.alertBG
            } else {
                self.view.backgroundColor = UIColor.Gray.alertDarkBG
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        delegate?.deinitController()
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension LoaderViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentController = LoaderPresentationController(presentedViewController: presented, presenting: presenting)
        return presentController
    }
}
