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
    func updateHeaderHeight(_ height: CGFloat)
}



protocol ProjectsViewModelType {
    var optionMenu: UIAlertController { get }
    var renameAlert: UIAlertController { get }
    var shareAlert: UIAlertController { get }
    var uploadAlertController: UIAlertController { get }
    var collectionView: ProjectsCollectionView { get }
    var plusButton: UIButton { get }
    var infoButton: UIButton { get }
    var delegate: ProjectsViewModelDelegate? { get set }
    var searchController: UISearchController { get }
    func update()
    func getAlertTextfield() -> String?
    var shareGUID: URL? { get }
}



class ProjectsViewModel: ProjectsViewModelType {
    
    var shareGUID: URL?
    
    private var projectItem: ProjectsCollectionViewCellVMType?
    
    weak var delegate: ProjectsViewModelDelegate?
    fileprivate let localFileFetcher: LocalFileFetcher = LocalFileFetcher()
    
    
    lazy var plusButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.backgroundColor = UIColor.Primary.primary
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    lazy var infoButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "question"), for: .normal)
        button.backgroundColor = UIColor.Primary.primary
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    @objc func infoButtonTapped(_ sender: UIButton) {
        sender.flash()
        delegate?.onEvents(type: .info)
    }
    
    
    var customView: ProjectsUploadView?
    
    
    lazy var uploadAlertController: UIAlertController = {
        
        let title = "Share.upload.title".localized
        let description = "Share.upload.desc".localized
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\(title)", message: description, preferredStyle: .alert)
        
        customView = ProjectsUploadView(frame: .zero, fileFetcher: self.fileFetcher, id: self.projectItem?.object.id )
        
        
        alert.view.addSubview(customView!)
        customView!.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -61).isActive = true
        customView!.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
        customView!.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 0).isActive = true
        customView!.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: 0).isActive = true
        customView!.delegate = self
        customView!.startUpload()
        
        return alert
    }()
    
    
    
    
    
    lazy var shareAlert: UIAlertController = {
        
        
        let title = "Share.title".localized
        let description = "Share.description".localized
        
        
        let shareAlert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        
        shareAlert.addAction(UIAlertAction(title: "Share.disagree".localized, style: .destructive))
        
        
        let agree = UIAlertAction(title: "Share.agree".localized, style: .default, handler: { [weak self] _ in
            
            if let customView = self?.customView {
                customView.startUpload()
            }
            self?.delegate?.onEvents(type: .uploadItem)
        })
        
        shareAlert.addAction(agree)
        shareAlert.view.tintColor = UIColor.Primary.primary
        
        return shareAlert
    }()
    
    
    
    
    lazy var renameAlert: UIAlertController = {
        
        
        
        let actionSheet = UIAlertController(title: "", message: "Projects.rename.desc".localized, preferredStyle: .alert)
        
        
        actionSheet.addAction(UIAlertAction(title: "Projects.cancel".localized, style: .cancel, handler: { [weak self] _ in
            //            actionSheet.textFields?.first?.text = self?.projectItem?.object.name
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Projects.rename".localized, style: .destructive, handler: { [weak self] (action: UIAlertAction) in
            if let alertTextField = actionSheet.textFields?.first, alertTextField.text != nil {
                self?.renameItem(alertTextField.text!)
            }
        }))
        
        actionSheet.addTextField { [weak self] (textField) in
            
            textField.text = self?.projectItem?.object.name
        }
        
        actionSheet.setTitlet(font: UIFont.getTTNormsFont(type: .medium, size: 14), color: nil)
        
        return actionSheet
    }()
    
    func getAlertTextfield() -> String? {
        return self.projectItem?.object.name
    }
    
    
    
    lazy var optionMenu: UIAlertController = {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(setupAlertAction(.open, someHandler: { [weak self] _ in self?.openItem() }))
        
        actionSheet.addAction(setupAlertAction(.rename, someHandler: { [weak self] _ in
            
            
            //            self?.renameItem("ololo")
            
            self?.delegate?.onEvents(type: .renameAlert)
        }))
        
        actionSheet.addAction(setupAlertAction(.share, someHandler: { [weak self] _ in self?.shareItem() }))
        actionSheet.addAction(setupAlertAction(.delete, someHandler: { [weak self] _ in self?.deleteItem() }))
        actionSheet.addAction(setupAlertAction(.cancel, someHandler: nil))
        
        //        actionSheet.view.tintColor = UIColor.Primary.primary
        
        actionSheet.setTitlet(font: UIFont.getTTNormsFont(type: .medium, size: 14), color: nil)
        
        
        return actionSheet
    }()
    
    var collectionView: ProjectsCollectionView
    
    
    
    
    let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        //        searchController.searchResultsUpdater = self.viewModel
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search"
        search.view.backgroundColor = .random()
        return search
        
    }()
    
    let fileFetcher: LocalFileFetcher = LocalFileFetcher()
    
    
    
    
    init() {
        self.collectionView = ProjectsCollectionView(fileFetcher: fileFetcher)
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
        //        result.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
        
        
        //        if let image = UIImage(named: type.getIconName()) {
        //            result.setValue(image, forKey: "image")
        //        }
        
        //        if let image = UIImage(systemName: type.getIconName()) {
        //            result.setValue(image, forKey: "image")
        //        }
        //
        return result
    }
    
    
    
    // addAction Handlers
    
    
    fileprivate func deleteItem() {
        
        guard let guid = self.projectItem?.object.id else { return }
        
        
        localFileFetcher.removeFolder(guid)
        
        
        //        self.collectionView.deleteItems(at: [item.indexPath])
        //        print(item.indexPath)
        
        
        //        localFileFetcher.
        
        StorageManager.delete(id: guid) { [weak self] in
            self?.collectionView.reloadData()
            //            UIView.animate(withDuration: 0.1, animations: {
            //                self?.collectionView.deleteItems(at: [item.indexPath])
            //            }) { _ in
            //
            //            }
        }
        
        
        
    }
    
    
    fileprivate func openItem() {
        guard let project = self.projectItem else { return }
        delegate?.onEvents(type: .longTappedItem(type: .open, item: project))
    }
    
    fileprivate func renameItem(_ newValue: String) {
        guard let object = self.projectItem?.object else { return }
        
        
        StorageManager.update(object: ProjectFileModel(newValue: newValue, object: object)) { [weak self] in
            self?.collectionView.reloadData()
        }
        
    }
    
    
    
    fileprivate func shareItem() {
        guard let project = self.projectItem else { return }
        delegate?.onEvents(type: .longTappedItem(type: .share, item: project))
    }
    
}




//MARK: - ProjectsCollectionViewDelegate
extension ProjectsViewModel: ProjectsCollectionViewDelegate {
    // hueta polneyshaya
    func scrollCellBegin(_ scrollView: UIScrollView) {
        let y = 120 - (scrollView.contentOffset.y + 120)
        let height = min(max(y, 0), 120)
        delegate?.updateHeaderHeight(height)
    }
    
    
    func didLongTapped(_ item: ProjectsCollectionViewCellVMType, _ type: CustomAlertAction) {
        self.projectItem = item
        switch type {
        case .open:
            self.openItem()
        case .rename:
            self.delegate?.onEvents(type: .longTappedItem(type: .rename, item: item))
        case .share:
            self.shareItem()
        case .delete:
            self.deleteItem()
        case .cancel: break
        }
    }
    
    func didSelectMore(_ item: ProjectsCollectionViewCellVMType) {
        self.projectItem = item
        delegate?.onEvents(type: .more)
    }
    
    func didSelectItemAt() {
        delegate?.onEvents(type: .didSelectItemAt)
    }
}


//MARK: - ProjectsCollectionViewDelegate
extension ProjectsViewModel: ProjectsUploadViewDelegate {
    func dissmis(_ guid: String?) {
        if guid != nil {
            if let link = URL(string: "https://share.arq.studio/\(String(describing: guid))") {
                self.shareGUID = link

            }
//            if let link = URL(string: "https://arq.studio") {
//                self.shareGUID = link
//            }
        }
        
//        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) {[weak self] _ in
            self.uploadAlertController.dismiss(animated: true, completion: nil)
            self.delegate?.onEvents(type: .share(guid))
//        }
      
    }
}

