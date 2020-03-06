//
//  ToastPresentationController.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 26.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit

protocol ToastPresentationControllerDelegate: class {
    func close()
}


class ToastPresentationController: PresentationController {
    
    weak var closeDelegate: ToastPresentationControllerDelegate?
    
    let visualEffectView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.effect = nil
        return view
    }()
    
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView,
            let presentedView = presentedView else { return .zero }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
        containerView.addGestureRecognizer(tapGestureRecognizer)
        
        
        let inset: CGFloat = 16
        
        // Make sure to account for the safe area insets
        let safeAreaFrame = containerView.bounds
            .inset(by: containerView.safeAreaInsets)
        
        let targetWidth = safeAreaFrame.width - 2 * inset
        let fittingSize = CGSize(
            width: targetWidth,
            height: UIView.layoutFittingCompressedSize.height
        )
        let targetHeight = presentedView.systemLayoutSizeFitting(
            fittingSize, withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow).height
        
        var frame = safeAreaFrame
        frame.origin.x += inset
        frame.origin.y += frame.size.height - targetHeight - inset
        frame.size.width = targetWidth
        frame.size.height = targetHeight
        
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
    @objc private func close() {
        self.closeDelegate?.close()
    }
    
}
