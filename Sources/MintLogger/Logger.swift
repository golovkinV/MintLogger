//
//  Logger.swift
//  
//
//  Created by Vladimir Golovkin on 16.12.2021.
//

import Foundation

public final class Logger {
    internal var registeredLoggers: [LoggerRegisterContainer] = []
    internal var disabledSymbols = Set<String>()
    fileprivate(set) static var sharedInstance = Logger()

    public init() {}
    
    /// Overrides shared instance, useful for testing
    public static func setSharedInstance(_ logger: Logger) {
        self.sharedInstance = logger
    }

    public func registerLoggers(_ loggers: [LoggerRegisterContainer]) {
        registeredLoggers = loggers
    }
    
    public func ignoreClass(_ type: AnyClass) {
        self.disabledSymbols.insert(String(describing: type))
    }

    public func ignoreTag(_ tag: LogTag) {
        self.disabledSymbols.insert(tag.rawValue)
    }

    public func log(_ loggerType: LoggerRegisterType, _ level: LogLevel, tag: LogTag, className: String, _ message: String) {
        guard self.logAllowed(tag, className: className) else {
            return
        }
        
        self.registeredLoggers
            .first(where: { $0.type == loggerType })?
            .logger?
            .log(level, tag: tag, className: className, message)
    }

    fileprivate func logAllowed(_ tag: LogTag, className: String) -> Bool {
        return !self.disabledSymbols.contains(className) && !self.disabledSymbols.contains(tag.rawValue)
    }
}
