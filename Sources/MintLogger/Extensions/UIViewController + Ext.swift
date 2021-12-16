//
//  UIViewController + Ext.swift
//  
//
//  Created by Vladimir Golovkin on 16.12.2021.
//

import UIKit

extension UIViewController: Loggable {
    public var loggingTag: LogTag {
        return .viewController
    }
}
