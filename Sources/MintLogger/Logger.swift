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

    /// Overrides shared instance, useful for testing
    static func setSharedInstance(_ logger: Logger) {
        self.sharedInstance = logger
    }

    func registerLoggers(_ loggers: [LoggerRegisterContainer]) {
        registeredLoggers = loggers
    }
    
    func ignoreClass(_ type: AnyClass) {
        self.disabledSymbols.insert(String(describing: type))
    }

    func ignoreTag(_ tag: LogTag) {
        self.disabledSymbols.insert(tag.rawValue)
    }

    func log(_ loggerType: LoggerRegisterType, _ level: LogLevel, tag: LogTag, className: String, _ message: String) {
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
