//
//  ProjectsViewController.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 19.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

final class ProjectsViewController: UIViewController {
    
    
    fileprivate var viewModel: ProjectsViewModelType?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ProjectsViewModel()
        setupUI()
        
        
    }
    
    fileprivate func setupUI() {
        
        
        viewModel?.delegate = self
        guard let viewModel = viewModel else { return }
       
        view.addSubview(viewModel.collectionView)
        viewModel.collectionView.fillSuperview()
        
        
        
        viewModel.plusButton.isUserInteractionEnabled = true
        view.addSubview(viewModel.plusButton)
        viewModel.plusButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        viewModel.plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22).isActive = true
        viewModel.plusButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        viewModel.plusButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        
        
        title = "Projects"
        
//        let searchController = UISearchController(searchResultsController: nil)
//        //        searchController.searchResultsUpdater = self.viewModel
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        self.navigationItem.searchController = searchController
//        self.definesPresentationContext = true
//
//
        navigationController?.navigationBar.hideBottomHairline()
    }
    
    // MARK: settings Navigation bar
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    fileprivate func navigation(_ type: ProjectsNavigationType) {
        switch type {

        case .actionSheet:
            guard let viewModel = viewModel else { return }
            self.present(viewModel.optionMenu, animated: true, completion: nil)
        case .selectCloud:
            let viewController = SelectCloudViewController()
            viewController.delegate = self
            let navigationController = UINavigationController(rootViewController: viewController)
            self.present(navigationController, animated: true, completion: nil)
        case .openProject:
            print(viewModel?.collectionView.viewModel?.viewModelForSelectedRow())
        case .renameAlert:
            guard let viewModel = viewModel else { return }
            self.present(viewModel.renameAlert, animated: true, completion: nil)
        case .dismiss:
            self.dismiss(animated: true, completion: nil)
      
        }
    }
    
}



//MARK: - ProjectsViewModelDelegate

extension ProjectsViewController: ProjectsViewModelDelegate {
    func onEvents(type: ProjectsViewAction) {
        switch type {
        case .plus:
            self.navigation(.selectCloud)
        case .didSelectItemAt:
            self.navigation(.openProject)
        case .more:
            self.navigation(.actionSheet)
        case .longTappedItem(let type, let item):
            switch type {
            case .open:
                 print(#function)
                print(item)
            case .rename:
                self.navigation(.renameAlert)
            case .share:
                print(#function)
            default: break
            }
        case .renameAlert:
            self.navigation(.renameAlert)
        }
    }
}
    

//MARK: - SelectCloudViewController

extension ProjectsViewController: SelectCloudViewControllerDelegate {
    func deinitController() {
        self.viewModel?.update()
    }
}
