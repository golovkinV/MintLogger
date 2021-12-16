//
//  LoggerRegisterContainer.swift
//  
//
//  Created by Vladimir Golovkin on 16.12.2021.
//

import Foundation

public struct LoggerRegisterContainer {
    let type: LoggerRegisterType
    private(set) var logger: LoggerType?
    
    public init(_ type: LoggerRegisterType) {
        self.type = type
        logger = type.fetchLogger()
    }
}
