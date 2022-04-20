//
//  NSObjectProtocol + Ext.swift
//  
//
//  Created by Vladimir Golovkin on 20.12.2021.
//

import Foundation

extension NSObjectProtocol {
    @discardableResult
    func apply(_ closure: (Self) -> () ) -> Self {
    { closure(self) }()
        return self
    }
}
