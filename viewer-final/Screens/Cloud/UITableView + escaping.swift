//
//  UITableView + escaping.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 25.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

extension UITableView {
    
    func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.deleteRows(at: indexPaths, with: .none)
        }){ _ in completion()}
    }
    
    func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.insertRows(at: indexPaths, with: .none)
        }){ _ in completion()}
    }
    
}
