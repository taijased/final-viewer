//
//  SelectCloudViewController.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

protocol SelectCloudViewControllerDelegate: class {
    func deinitController()
}

final class SelectCloudViewController: UIViewController {
    
    fileprivate var viewModel: SelectCloudVMType?
    weak var delegate: SelectCloudViewControllerDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SelectCloudVM()
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        
        
        
        view.backgroundColor = .random()
        
        viewModel?.onNavigate = { [weak self] navigation in
            self?.navigation(navigation)
        }
        
        guard let viewModel = viewModel else { return }
        
        view.addSubview(viewModel.tableView)
        viewModel.tableView.fillSuperview()
    }
    
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        
//    }
//    
//    
    
    
    
    fileprivate func navigation(_ nav: SelectCloudNavigation) {
        switch nav {
        case .documentPicker:
            guard let documentPicker = viewModel?.documentPicker else { return }
            documentPicker.delegate = self
            self.present(documentPicker, animated: true, completion: nil)
        case .errorFormat(let msg):
            self.showToast(msg)
        case .dismiss:
            self.dismiss(animated: true, completion: nil)
        case .supportedFormats:
            
            let viewController = FormatListViewController()
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    
    fileprivate func showToast(_ title: String) {
        let toast = ToastViewController(title: title)
        self.present(toast, animated: true)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            toast.dismiss(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    }

    
    //MARK: settings Navigation bar
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    deinit {
        delegate?.deinitController()
    }
    
}




//MARK: - UIDocumentPickerDelegate work with files from phone

extension SelectCloudViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let viewModel = viewModel else { return }
        viewModel.didPickDocumentsAt(urls: urls)
    }
}













