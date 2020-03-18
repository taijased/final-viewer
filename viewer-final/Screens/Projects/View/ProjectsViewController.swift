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
    
    fileprivate let emptyLabel: UILabel = {
        let label = UILabel.H3.medium
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "3D Models aren't"
        return label
    }()
    
    
    fileprivate let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    
    lazy fileprivate var headerLabel: UILabel = {
        let label = UILabel.H1.bold
        label.textColor = UIColor.Black.primary
        label.text = "Projects.title".localized
        label.font = UIFont.getTTNormsFont(type: .bold, size: 32)
        label.textAlignment = .left
        label.numberOfLines = 0
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
        viewModel.plusButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        viewModel.plusButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        
        
        
        viewModel.infoButton.isUserInteractionEnabled = true
        view.addSubview(viewModel.infoButton)
        viewModel.infoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        viewModel.infoButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        viewModel.infoButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        viewModel.infoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22).isActive = true
        
        
        if UIDevice.current.model == "iPad" {
            viewModel.plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        } else {
            viewModel.plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22).isActive = true
        }
        
        
        
        self.definesPresentationContext = true
        
        
        
        
        
        
        view.addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
    
        headerView.addSubview(headerLabel)
        headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 19).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 20).isActive = true
        

        
        
        navigationController?.navigationBar.hideBottomHairline()
        
        
    }
    
    
    
    
    // MARK: settings Navigation bar
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        DispatchQueue.main.async {
            if self.traitCollection.userInterfaceStyle == .light {
                self.view.backgroundColor = .white
                self.emptyLabel.textColor = UIColor.Black.primary
                self.viewModel?.infoButton.backgroundColor = UIColor.Gray.primaryLight
                self.viewModel?.infoButton.setImage(UIImage(named: "question-light"), for: .normal)
                self.headerLabel.textColor = UIColor.Black.primary
                
            } else {
                self.view.backgroundColor = UIColor.Black.light
                self.emptyLabel.textColor = .white
                self.viewModel?.infoButton.backgroundColor = UIColor.Gray.darkLight
                self.viewModel?.infoButton.setImage(UIImage(named: "question-dark"), for: .normal)
                self.headerLabel.textColor = .white
            }
        }
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            viewModel?.collectionView.reloadData()
        } else {
            viewModel?.collectionView.reloadData()
        }
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
            guard let object = viewModel?.collectionView.viewModel?.viewModelForSelectedRow() else { return }
            
        case .renameAlert:
            guard let renameAlert = viewModel?.renameAlert else { return }
            self.present(renameAlert, animated: true, completion: nil)
        case .dismiss:
            self.dismiss(animated: true, completion: nil)
            
        case .information:
            let viewController = InformationViewController()
            //            let viewController = TestViewController()
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
}



//MARK: - ProjectsViewModelDelegate

extension ProjectsViewController: ProjectsViewModelDelegate {
    
    func updateHeaderHeight(_ height: CGFloat) {
        self.headerView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = height
            }
        }
    }
    
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
        case .info:
            self.navigation(.information)
        }
    }
}


//MARK: - SelectCloudViewController

extension ProjectsViewController: SelectCloudViewControllerDelegate {
    func deinitController() {
        self.viewModel?.update()
    }
}
