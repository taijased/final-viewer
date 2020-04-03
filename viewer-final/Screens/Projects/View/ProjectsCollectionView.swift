

import UIKit
import AlignedCollectionViewFlowLayout


protocol ProjectsCollectionViewDelegate: class {
    func didSelectItemAt()
    func didSelectMore(_ item: ProjectsCollectionViewCellVMType)
    func didLongTapped(_ item: ProjectsCollectionViewCellVMType, _ type: CustomAlertAction)
    func scrollCellBegin(_ scrollView: UIScrollView)
}



class ProjectsCollectionView: UICollectionView {
    
    var viewModel: ProjectsCollectionViewVMType?
    weak var collectionDelegate: ProjectsCollectionViewDelegate?

    
    
    init(fileFetcher: LocalFileFetcher) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        //
        //        let layout = AlignedCollectionViewFlowLayout(horizontalAlignment: .justified, verticalAlignment: .center)
        //        super.init(frame: .zero, collectionViewLayout: layout)
        
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        
        
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewModel = ProjectsCollectionViewVM(fileFetcher: fileFetcher)
        
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
//        register(ProjectsCollectionHeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProjectsCollectionHeaderViewCell.reuseId)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 80, left:  20, bottom: 100, right: 20)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = traitCollection.userInterfaceStyle == .light ? .white : UIColor.Black.light
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



//// MARK: - UICollectionViewDelegateFlowLayout
extension ProjectsCollectionView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return viewModel?.sizeForItemAt(collectionView.frame.size) ?? CGSize.zero
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
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionDelegate?.scrollCellBegin(scrollView)
    }
    
    
    
    // MARK: - Add HomeHeaderViewCell
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProjectsCollectionHeaderViewCell.reuseId, for: indexPath)
//            as? ProjectsCollectionHeaderViewCell
//        guard let headerViewCell = cell else { return UICollectionViewCell() }
//
//        return headerViewCell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.width, height: 80)
//    }
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

