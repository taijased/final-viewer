//
//  ProjectsContextViewMenu.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 19.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import Foundation
import UIKit

enum ProjectsContextViewMenuEnum {
    case delete
    case open
    case share
    case settings
}

protocol ProjectsContextViewMenu {
    
}

extension ProjectsContextViewMenu {
    func makeDefaultDemoMenu(completion: @escaping (ProjectsContextViewMenuEnum) -> Void) -> UIMenu {

        
        let open = UIAction(title: "Open", image: UIImage(systemName: "square.and.arrow.up"), attributes: .init()) { action in
            completion(.open)
        }
        
        
        let share = UIAction(title: "Share", image: UIImage(systemName: "icloud.fill"), attributes: .init()) { action in
            completion(.share)
        }
        
        let settings = UIAction(title: "Settings", image: UIImage(systemName: "square.and.pencil"), attributes: .init()) { action in
            completion(.settings)
        }
        
        let delete = UIAction(title: "Delete from cashe", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
            completion(.delete)
        }
        
        
        let testOpen = UIMenu(title: "Open", options: .displayInline, children: [open])

        
        return UIMenu(title: "", children: [testOpen, share, settings, delete])

    }
}
