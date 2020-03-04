//
//  ARViewControls.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 04.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit


enum ARViewControlsEnum {
    case close
    case openAR
    case open3D
}

protocol ARViewControlsDelegate: class {
    func controlsActions(_ type: ARViewControlsEnum)
}

final class ARViewControls: UIView {
    
    weak var delegate: ARViewControlsDelegate?
    
    fileprivate let closeButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.Red.primary
        button.setImage(UIImage(named: "close-white"), for: .normal)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
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
    
    
    
    
    @objc fileprivate func closeButtonTapped(_ sender: UIButton) {
        sender.flash()
        delegate?.controlsActions(.close)
    }
    
    
    @objc fileprivate func segmentControlChenge(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            delegate?.controlsActions(.open3D)
        case 1:
            delegate?.controlsActions(.openAR)
        default:
            break
        }
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    
    fileprivate func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        addSubview(closeButton)
        closeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        addSubview(segmentControl)
        segmentControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        segmentControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalToConstant: 141).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
