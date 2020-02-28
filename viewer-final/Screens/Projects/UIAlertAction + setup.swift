//
//  UIAlertAction + setup.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 28.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit

extension UIAlertAction {
    static func setup(_ type: CustomAlertAction, someHandler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
          let result = UIAlertAction(title: type.getTitleName(), style: type.getStyle(), handler: someHandler)
          if let image = UIImage(named: type.getIconName()) {
              result.setValue(image, forKey: "image")
          }
          return result
    }
}
