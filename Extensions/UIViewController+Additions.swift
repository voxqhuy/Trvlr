//
//  UIViewController+ID.swift
//  Trvlr
//
//  Created by Vo Huy on 8/6/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

extension UIViewController {
    class var storyboardID : String {
        return "\(self)" + "_ID"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard : AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
