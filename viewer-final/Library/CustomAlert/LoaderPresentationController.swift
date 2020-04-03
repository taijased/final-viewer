//
//  LoaderPresentationController.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 03.04.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit


class LoaderPresentationController: PresentationController {
    
    
    let visualEffectView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.effect = nil
        return view
    }()
    
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        
        // Make sure to account for the safe area insets
        let safeAreaFrame = containerView.bounds
            .inset(by: containerView.safeAreaInsets)
       
        
        var frame = safeAreaFrame
        frame.origin.x = (safeAreaFrame.size.width - 271) / 2
        frame.origin.y = (safeAreaFrame.size.height - 205) / 2
        frame.size.width = 271
        frame.size.height = 205
        
        return frame
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        presentedView?.layer.cornerRadius = 12
        
        containerView?.addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        
        if let coordinator = presentingViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { [weak self] _ in
                
                if self?.traitCollection.userInterfaceStyle == .light {
                    self?.visualEffectView.effect = UIBlurEffect(style: .extraLight)
                    
                } else {
                    self?.visualEffectView.effect = UIBlurEffect(style: .dark)
                }
                
                
                self?.containerView?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.01)
                }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentingViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { [weak self] _ in
                self?.containerView?.backgroundColor = .clear
                self?.visualEffectView.effect = nil
                }, completion: nil)
        }
    }
    
}
