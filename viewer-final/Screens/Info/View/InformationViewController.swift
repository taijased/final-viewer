//
//  InformationViewController.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 16.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

final class InformationViewController: UIViewController {
    
    
    
    fileprivate let segmentControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "3D", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "AR", at: 1, animated: true)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentControlChenge(_:)), for: .valueChanged)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.selectedSegmentTintColor = UIColor.Primary.primary
        segmentedControl.layer.borderColor = UIColor.Primary.primary.cgColor
        return segmentedControl
    }()
    
    
    @objc fileprivate func segmentControlChenge(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            print(#function)
        case 1:
            print(#function)
        default:
            break
        }
    }
    
    var viewModel: InformationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        
//        view.backgroundColor = .random()
        
        view.addSubview(segmentControl)
        
        segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 22).isActive = true
        segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if traitCollection.userInterfaceStyle == .light {
            view.backgroundColor = .white
            
        } else {
            view.backgroundColor = UIColor.Black.light
        }
    }
    
    
}
