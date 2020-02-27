//
//  CloudViewController.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 25.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

final class CloudViewController: UIViewController {
    

    
    
    fileprivate var viewModel: CloudViewModelType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CloudViewModel()
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        view.backgroundColor = .white
        
        guard let viewModel = viewModel else { return }
        view.addSubview(viewModel.tableView)
        viewModel.tableView.fillSuperview()
        
        
        viewModel.tableView.viewModel?.onNavigate = { [weak self] navItem in
            self?.navigation(.selectCloud)
        }
    }
    
    
    
    fileprivate func navigation(_ navItem: CloudNavigation) {
        switch navItem {
        case .selectCloud:
            let toast = CloudPopUpViewController()
            toast.modalPresentationStyle = .overFullScreen
            toast.modalTransitionStyle = .crossDissolve
            self.present(toast, animated: true)
            
        case .dismiss:
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
    
}

