//
//  CloudPopUpViewControllerVM.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 27.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit


protocol CloudPopUpViewControllerVMType {
    var popupView: UIView { get set }
    var onDismiss: (() -> Void)? { get set }
}

class CloudPopUpViewControllerVM: CloudPopUpViewControllerVMType {
    
    var onDismiss: (() -> Void)?
    var popupView: UIView
    
    init() {
        let tableView = CPopUpTableView(frame: .zero)
        popupView = tableView
        
        tableView.viewModel?.onDismiss = {
            self.onDismiss?()
        }
    }
}
