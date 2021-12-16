//
//  LoggerType.swift
//  
//
//  Created by Vladimir Golovkin on 16.12.2021.
//

import Foundation

// MARK: Logger type
/// Protocol for custom logger which should be registered
public protocol LoggerType {
    func log(_ level: LogLevel, tag: LogTag, className: String, _ message: String)
}
