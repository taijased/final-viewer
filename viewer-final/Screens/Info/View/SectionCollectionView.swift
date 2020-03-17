//
//  SectionCollectionView.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 17.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit

struct SectionViewModel {
    
}



protocol SectionCollectionViewDelegate: class {
    func currentPage(indexPage: Int)
    func scrollCellBegin(_ scrollView: UIScrollView)
}


class SectionCollectionView: UICollectionView {
    
    var cells: Int?

    
    weak var sectionDelegate: SectionCollectionViewDelegate?
 
    
    init(section: Int) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        setupCollectionSettings()
        cells = section
    }
    
    
    func scrollSection(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func getSectionSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    private func setupCollectionSettings() {
        backgroundColor = .clear
        delegate = self
        dataSource = self
        register(SectionCollectionViewCellAR.self, forCellWithReuseIdentifier: SectionCollectionViewCellAR.reuseId)
        register(SectionCollectionViewCell3D.self, forCellWithReuseIdentifier: SectionCollectionViewCell3D.reuseId)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        backgroundColor = .white
        isPagingEnabled = true
        
        isScrollEnabled = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SectionCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell
        
        
        if indexPath.row == 0 {
            cell = dequeueReusableCell(withReuseIdentifier: SectionCollectionViewCell3D.reuseId, for: indexPath) as! SectionCollectionViewCell3D
                  
        } else {
            cell = dequeueReusableCell(withReuseIdentifier: SectionCollectionViewCellAR.reuseId, for: indexPath) as! SectionCollectionViewCellAR
        }
         
        return cell
    }
}

// MARK:  UICollectionViewDelegateFlowLayout

extension SectionCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
