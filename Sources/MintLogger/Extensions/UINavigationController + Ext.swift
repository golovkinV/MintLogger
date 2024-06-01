//
//  UINavigationController + Ext.swift
//  
//
//  Created by Vladimir Golovkin on 01.06.2024.
//

import UIKit

extension UINavigationController {
    
    static var topViewController: UIViewController? {
        var top = UIApplication.shared.keyWindow?.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}
