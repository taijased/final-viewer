//
//  SelectCloudViewController.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

final class SelectCloudViewController: UIViewController {
    
    fileprivate var viewModel: SelectCloudVMType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SelectCloudVM()
        setupUI()
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .random()
        
        guard let viewModel = viewModel else { return }
        
        view.addSubview(viewModel.tableView)
        viewModel.tableView.fillSuperview()
        
    }
    
    
}
