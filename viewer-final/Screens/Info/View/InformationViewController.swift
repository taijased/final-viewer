//
//  InformationViewController.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 16.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

final class InformationViewController: UIViewController {
    
    
    var viewModel: InformationViewModelType?
    
    
    let visualEffectView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = InformationViewModel()
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        
        
        
        guard let viewModel = viewModel else { return }
        
        view.addSubview(viewModel.sectionCollectionView)
        viewModel.sectionCollectionView.fillSuperview()
        
        
        view.addSubview(visualEffectView)
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.heightAnchor.constraint(equalToConstant: 96).isActive = true
        
        view.addSubview(viewModel.segmentControl)
        viewModel.segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        viewModel.segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22).isActive = true
        viewModel.segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22).isActive = true
        viewModel.segmentControl.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if traitCollection.userInterfaceStyle == .light {
            view.backgroundColor = .white
            visualEffectView.effect = UIBlurEffect(style: .extraLight)
        } else {
            view.backgroundColor = UIColor.Black.light
            visualEffectView.effect = UIBlurEffect(style: .dark)
        }
    }
    
}
