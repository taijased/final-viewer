//
//  InformationViewModel.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 16.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit



protocol InformationViewModelType {
    var segmentControl: UISegmentedControl { get }
    var sectionCollectionView: SectionCollectionView { get }
}

final class InformationViewModel: InformationViewModelType {
    let sectionCollectionView: SectionCollectionView
    let segmentControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "3D", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "AR", at: 1, animated: true)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.selectedSegmentTintColor = UIColor.Primary.primary
        segmentedControl.layer.borderColor = UIColor.Primary.primary.cgColor
        return segmentedControl
    }()
    
    @objc fileprivate func segmentControlChenge(_ sender: UISegmentedControl) {
        self.sectionCollectionView.scrollSection(index: sender.selectedSegmentIndex)
    }
    
    
    
    init() {
        sectionCollectionView = SectionCollectionView(section: segmentControl.numberOfSegments)
        segmentControl.addTarget(self, action: #selector(segmentControlChenge(_:)), for: .valueChanged)
    }
}
