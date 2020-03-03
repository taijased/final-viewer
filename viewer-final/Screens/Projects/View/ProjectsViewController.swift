//
//  ProjectsViewController.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 19.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit
import Bartinter

final class ProjectsViewController: UIViewController {
    
    
    fileprivate var viewModel: ProjectsViewModelType?
    
    fileprivate let emptyLabel: UILabel = {
        let label = UILabel.H3.medium
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "3D Models aren't"
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ProjectsViewModel()
        setupUI()
        
        
    }
    
    
    
    
    fileprivate func setupUI() {
        
        
        
        
        view.addSubview(emptyLabel)
        emptyLabel.fillSuperview()
        
        
        
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
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if traitCollection.userInterfaceStyle == .light {
            
            view.backgroundColor = .white
            emptyLabel.textColor = UIColor.Black.primary
            
            
            
        } else {
            view.backgroundColor = UIColor.Black.light
            
            emptyLabel.textColor = .white
            
            
        }
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
            guard let optionMenu = viewModel?.optionMenu else { return }
            self.present(optionMenu, animated: true, completion: nil)
        case .selectCloud:
            let viewController = SelectCloudViewController()
            viewController.delegate = self
            let navigationController = UINavigationController(rootViewController: viewController)
            self.present(navigationController, animated: true, completion: nil)
        case .openProject:
            
            
            guard let object = viewModel?.collectionView.viewModel?.viewModelForSelectedRow()?.path else { return }
            
            
            
            //            let documentsURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            //
            //
            //
            ////            print(documentsURL.appendingPathComponent("arqprojects"))
            //            let fileExist = documentsURL.appendingPathComponent("arqprojects").appendingPathComponent(path).checkFileExist()
            //
            //            print(se)
            
            //example use update RPS
            
            //            StorageManager.update(object: ProjectFileModel(objectRPS: "new Value RPS", object: object)) {
            //                print(object)
            //            }
            
            
            
            
            
            
            
            
        case .renameAlert:
            guard let renameAlert = viewModel?.renameAlert else { return }
            self.present(renameAlert, animated: true, completion: nil)
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
                print(item)
            case .rename:
                self.navigation(.renameAlert)
                //            case .share:
            //                print(#function)
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
