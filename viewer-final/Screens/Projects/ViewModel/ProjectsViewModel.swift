//
//  ProjectsViewModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 19.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit




protocol ProjectsViewModelDelegate: class {
    func onEvents(type: ProjectsViewAction)
}



protocol ProjectsViewModelType {
    var optionMenu: UIAlertController { get }
    var collectionView: ProjectsCollectionView { get }
    var plusButton: UIButton { get }
    var delegate: ProjectsViewModelDelegate? { get set }
    func update()
}



class ProjectsViewModel: ProjectsViewModelType {
    
    
    weak var delegate: ProjectsViewModelDelegate?
    
    
    lazy var plusButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.backgroundColor = UIColor.Primary.primary
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowRadius = 1.0
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var optionMenu: UIAlertController = {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        actionSheet.addAction(setupAlertAction(.open, someHandler: { (actions) in
            print(#function)
        }))
        
        actionSheet.addAction(setupAlertAction(.rename, someHandler: { (actions) in
            print(#function)
        }))
        actionSheet.addAction(setupAlertAction(.share, someHandler: { (actions) in
            print(#function)
        }))
        actionSheet.addAction(setupAlertAction(.deleteFile, someHandler: { (actions) in
            print(#function)
        }))
        
        actionSheet.addAction(setupAlertAction(.cancel, someHandler: { (actions) in
            print(#function)
        }))
        
        actionSheet.view.tintColor = UIColor.Primary.primary
        actionSheet.dismiss(animated: false, completion: nil)
        
        return actionSheet
    }()
    
    var collectionView: ProjectsCollectionView
    
    init() {
        self.collectionView = ProjectsCollectionView()
        self.collectionView.collectionDelegate = self
    }
    
    
    func update() {
        collectionView.reloadData()
    }
    
    
    @objc func plusButtonTapped(_ sender: UIButton) {
        sender.flash()
        delegate?.onEvents(type: .plus)
    }
    
    
    fileprivate func setupAlertAction(_ type: CustomAlertAction, someHandler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
        let result = UIAlertAction(title: type.getTitleName(), style: type.getStyle(), handler: someHandler)
        if let image = UIImage(named: type.getIconName()) {
            result.setValue(image, forKey: "image")
        }
        return result
    }
    
}




//MARK: - ProjectsCollectionViewDelegate
extension ProjectsViewModel: ProjectsCollectionViewDelegate {
    func didSelectMore() {
        delegate?.onEvents(type: .more)
    }
    
    func didSelectItemAt() {
        delegate?.onEvents(type: .didSelectItemAt)
    }
}


