//
//  CloudPopUpViewController.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 27.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit

final class CloudPopUpViewController: UIViewController {
    
    
    fileprivate var viewModel: CloudPopUpViewControllerVMType?
    
    fileprivate let visualEffectView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.effect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        return view
    }()
    
    fileprivate let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.backgroundColor = .white
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CloudPopUpViewControllerVM()
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        
        view.insertSubview(visualEffectView, at: 10)
        visualEffectView.fillSuperview()
        contentView.frame = CGRect(x: 16, y: 65, width: view.frame.width - (2 * 16), height: 0)
        view.addSubview(contentView)
        
        viewModel?.onDismiss = {
            self.dismiss(animated: true, completion: nil)
        }
        
        
        guard let viewModel = viewModel else { return }
        contentView.addSubview(viewModel.popupView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let viewModel = viewModel else { return }
        
        viewModel.popupView.frame.size.width = view.frame.width - (2 * 16)
        viewModel.popupView.layer.cornerRadius = 10
        
        UIView.animate(withDuration: 0.25, animations: {
            self.contentView.frame.size.height = 336
            viewModel.popupView.frame.size.height = 336
        })
    }
    
}
