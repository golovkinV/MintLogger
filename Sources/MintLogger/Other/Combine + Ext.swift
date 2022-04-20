//
//  Combine + Ext.swift
//  
//
//  Created by Vladimir Golovkin on 20.12.2021.
//

import Foundation
import Combine

extension AnyPublisher {
    func apiAnyPublisher() -> AnyPublisher {
        self.subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
}
