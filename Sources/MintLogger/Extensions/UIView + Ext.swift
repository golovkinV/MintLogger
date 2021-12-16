//
//  File.swift
//  
//
//  Created by Vladimir Golovkin on 16.12.2021.
//

import UIKit

extension UIView: Loggable {
    public var loggingTag: LogTag {
        return .view
    }
}
