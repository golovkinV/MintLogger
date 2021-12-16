//
//  MoyaNetworkLogger + Pulse.swift
//  
//
//  Created by Vladimir Golovkin on 16.12.2021.
//

import Foundation
import Pulse
import Alamofire

public struct MoyaNetworkLogger: EventMonitor {
    let logger: NetworkLogger

    public func request(_ request: Request, didCreateTask task: URLSessionTask) {
        logger.logTaskCreated(task)
    }

    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        logger.logDataTask(dataTask, didReceive: data)
    }

    public func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        logger.logTask(task, didFinishCollecting: metrics)
    }

    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        logger.logTask(task, didCompleteWithError: error)
    }
}
