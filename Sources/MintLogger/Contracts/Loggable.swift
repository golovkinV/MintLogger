//
//  Loggable.swift
//  
//
//  Created by Vladimir Golovkin on 16.12.2021.
//

import Foundation

// MARK: Loggable
/// Protocol for models which are logging data
public protocol Loggable {
    var loggingTag: LogTag { get }

    func log(_ level: LogLevel, _ message: String)
    func log(_ loggerType: LoggerRegisterType, _ level: LogLevel, _ message: String)
    func log(_ loggerType: LoggerRegisterType, _ level: LogLevel, tag: LogTag, _ message: String)
}

public extension Loggable {
    
    var loggingTag: LogTag {
        return .unnamed
    }
    
    func log(_ level: LogLevel, _ message: String) {
        self.log(.simple, level, tag: loggingTag, message)
    }
    
    func log(_ loggerType: LoggerRegisterType, _ level: LogLevel, _ message: String) {
        self.log(loggerType, level, tag: loggingTag, message)
    }
    
    func log(_ loggerType: LoggerRegisterType, _ level: LogLevel, tag: LogTag, _ message: String) {
        Logger.sharedInstance.log(loggerType, level, tag: tag, className: String(describing: type(of: self)), message)
    }
}
