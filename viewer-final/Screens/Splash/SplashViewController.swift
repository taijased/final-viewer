//
//  SplashViewController.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 18.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

final class SplashViewController: UIViewController {
    
    
    var deinitViewController: (() -> Void)?
    
    fileprivate let logoView: ARQIconView = {
        let view = ARQIconView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fillColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.Primary.primary
        view.addSubview(logoView)
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        setupAnimation()
    }
    
    //Animation: - Bounce
    func setupAnimation() {
        
        UIView.animate(withDuration: 1.75, animations: {
            self.logoView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.25, animations: {
                self.logoView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.view.alpha = 0.0
            }) { _ in
              
                self.checkRoute()
            }
        }
    }
    
    fileprivate func checkRoute() {
        if realm.isEmpty {
            let viewController = WelcomeViewController()
            viewController.delegate = self
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        } else {
            self.deinitViewController?()
        }
    }
    
    
    
    
    // MARK: settings Navigation bar
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
}



//MARK: - implementation of the delegate from WelcomeViewControllerDelegate

extension SplashViewController: WelcomeViewControllerDelegate {
    func deinitController() {
        self.deinitViewController?()
    }
}
