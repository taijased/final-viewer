//
//  ProjectsViewAction.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 28.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation


enum ProjectsViewAction {
    case info
    case more
    case plus
    case didSelectItemAt
    case longTappedItem(type: CustomAlertAction, item: ProjectsCollectionViewCellVMType)
    case renameAlert
    case uploadItem
    case share(_ guid: String?)
    case download
}
