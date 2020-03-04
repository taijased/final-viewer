//
//  ProjectsContextViewMenu.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 19.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit

//enum ProjectsContextViewMenuEnum {
//    case delete
//    case open
//    case share
//    case settings
//}

protocol ProjectsContextViewMenu {
    
}



extension ProjectsContextViewMenu {
    func makeDefaultDemoMenu(completion: @escaping (CustomAlertAction) -> Void) -> UIMenu {
        
        
        var menuItems = [UIMenuElement]()
        
        let open =  UIMenu(title: "Open", options: .displayInline, children: [self.setupCustomAction(.open, someHandler: { (action) in
                       completion(.open)
                   })])
        
        
        
        
        
        menuItems.append(open)
        //        menuItems.append(self.setupCustomAction(.share, someHandler: { (action) in
        //            completion(.share)
        //        }))
        //
        
        menuItems.append(self.setupCustomAction(.rename, someHandler: { (action) in
            completion(.rename)
        }))
        
        menuItems.append(self.setupCustomAction(.delete, someHandler: { (action) in
            completion(.delete)
        }))
        
        
        
    
        
        
        
        
        return UIMenu(title: "", children: menuItems)
    }
    
    
    fileprivate func setupCustomAction(_ type: CustomAlertAction, someHandler: @escaping ((UIAction) -> Void)) -> UIAction {
        
      
        
        
//        let title = type.getTitleName()
//
//        let attributeString = NSMutableAttributedString(string: title)//1
//        let titleFont = UIFont.getTTNormsFont(type: .extraBold, size: 14)
//        attributeString.addAttributes([NSAttributedString.Key.font : titleFont], range: NSMakeRange(0, title.utf8.count))
        let result = UIAction(title: type.getTitleName(), handler: someHandler)
        
        switch type {
        case .open:
            result.attributes = .init()
        case .rename:
            result.attributes = .init()
            //        case .share:
        //            result.attributes = .init()
        case .delete:
            result.attributes = .destructive
        case .cancel:
            result.attributes = .hidden
        }
        
        
        //        if let image = UIImage(named: type.getIconName()) {
        //            result.setValue(image, forKey: "image")
        //        }
        //

        
        if let image = UIImage(systemName: type.getIconName()) {
            result.setValue(image, forKey: "image")
        }

        
        
        
        return result
        
    }
    
    
}


extension UIMenuElement {
    func setTitlet(font: UIFont?, color: UIColor?) {
        let title = self.title
        let attributeString = NSMutableAttributedString(string: title)//1
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                                          range: NSMakeRange(0, title.utf8.count))
        }
        
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                                          range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")//4
    }

}


