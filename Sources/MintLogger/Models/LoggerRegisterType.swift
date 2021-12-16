//
//  LoggerRegisterType.swift
//  
//
//  Created by Vladimir Golovkin on 16.12.2021.
//

import Foundation

public enum LoggerRegisterType {
    case simple, pulse
    
    func fetchLogger() -> LoggerType? {
        switch self {
        case .simple:
            return SimpleLogger()
        case .pulse:
            return nil
        }
    }
}
