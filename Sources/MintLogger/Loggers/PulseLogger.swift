//
//  PulseLogger.swift
//  
//
//  Created by Vladimir Golovkin on 16.12.2021.
//

import Logging
import Foundation
import UIKit
import PulseUI
import Pulse
import Combine

public typealias UIEventSubtype = UIEvent.EventSubtype

public final class UIPulseWindow: UIWindow {
    
    public let openPulsePublisher = PassthroughSubject<UIViewController, Never>()
    
    override public func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        #if DEBUG
            openPulse(motion, with: event)
        #endif
    }
    
    private func openPulse(_ motion: UIEventSubtype, with event: UIEvent?) {
        guard let rootVC = self.rootViewController else { return }
        if (event!.type == .motion && event!.subtype == .motionShake),
           !(rootVC is PulseUI.MainViewController) {
            openPulsePublisher.send(rootVC)
        } else {
            super.motionEnded(motion, with: event)
        }
    }
}


public final class PulseLogger: LoggerType {
    
    private var logger: Logging.Logger {
        let label = Bundle.main.bundleIdentifier ?? "pulse_logger"
        return Logging.Logger(label: label)
    }
    
    public init() {
        LoggingSystem.bootstrap(PersistentLogHandler.init)
    }
    
    public func log(_ level: LogLevel, tag: LogTag, className: String, _ message: String) {
        switch level {
        case .debug:
            logger.debug("🟢 DEBUG: \n[\(className)]\n -> \(message)")
        case .info:
            logger.info("🔵 INFO: \n[\(className)]\n -> \(message)")
        case .warning:
            logger.warning("🟡 WARNING: \n[\(className)]\n -> \(message)")
        case .error:
            logger.error("🔴 ERROR: \n[\(className)]\n -> \(message)")
        default:
            logger.notice("🟣 VERBOSE: \n[\(className)]\n -> \(message)")
        }
    }
}
