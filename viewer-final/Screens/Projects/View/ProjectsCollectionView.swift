

import UIKit


protocol ProjectsCollectionViewDelegate: class {
    func didSelectItemAt()
    func didSelectMore(_ item: ProjectsCollectionViewCellVMType)
    func didLongTapped(_ item: ProjectsCollectionViewCellVMType, _ type: CustomAlertAction)
}



class ProjectsCollectionView: UICollectionView {
    
    var viewModel: ProjectsCollectionViewVMType?
    weak var collectionDelegate: ProjectsCollectionViewDelegate?
    
    
  
    
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        
        
        viewModel = ProjectsCollectionViewVM()
        
        viewModel?.onReloadData = { [weak self] in
            self?.updateBackground()
            self?.reloadData()
        }
        
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        setupCollectionSettings()
    }
    
    
    
    fileprivate func setupCollectionSettings() {
        backgroundColor = .clear
        
        delegate = self
        dataSource = self
        register(ProjectsCollectionViewCell.self, forCellWithReuseIdentifier: ProjectsCollectionViewCell.reuseId)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 20, left:  20, bottom: 0, right:  20)
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if traitCollection.userInterfaceStyle == .light {
            backgroundColor = .white
            
        } else {
            backgroundColor = UIColor.Black.light
        }
        
        
       updateBackground()
    }
    
    func updateBackground() {
        if viewModel?.isEmpty() ?? true {
            self.alpha = 0
        } else {
            self.alpha = 1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension ProjectsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: ProjectsCollectionViewCell.reuseId, for: indexPath) as? ProjectsCollectionViewCell
        
        guard let collectionViewCell = cell, let viewModel = viewModel else { return UICollectionViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        collectionViewCell.viewModel = cellViewModel
        collectionViewCell.delegate = self
        
        return collectionViewCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectItem(atIndexPath: indexPath)
        //        guard viewModel.viewModelForSelectedRow() != nil else { return }
        collectionDelegate?.didSelectItemAt()
    }
}



// MARK: - UICollectionViewDelegateFlowLayout
extension ProjectsCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel?.sizeForItemAt() ?? CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel?.minimumInteritemSpacingForSectionAt ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel?.minimumLineSpacingForSectionAt ?? 0
    }
}


//MARK: - ProjectsContextViewMenu

extension ProjectsCollectionView: ProjectsContextViewMenu {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            return self.makeDefaultDemoMenu { [weak self] type in
                guard let viewModel = (collectionView.cellForItem(at: indexPath) as? ProjectsCollectionViewCell)?.viewModel else { return }
                self?.collectionDelegate?.didLongTapped(viewModel, type)
            }
        }
    }
}


//MARK: - ProjectsCollectionViewCellDelegate

extension ProjectsCollectionView: ProjectsCollectionViewCellDelegate {
    func moreTapped(_ item: ProjectsCollectionViewCellVMType) {
        collectionDelegate?.didSelectMore(item)
    }
}



