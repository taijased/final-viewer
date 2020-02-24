//
//  FormatListViewController.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//



import UIKit

final class FormatListViewController: UIViewController {
    
    fileprivate var viewModel: FormatListVMType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FormatListVM()
        setupUI()
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .random()
        
        guard let viewModel = viewModel else { return }
        
        view.addSubview(viewModel.tableView)
        viewModel.tableView.fillSuperview()
        
    }
    
    
}
