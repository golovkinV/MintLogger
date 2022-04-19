//
//  FeatureProvider.swift
//  
//
//  Created by Vladimir Golovkin on 20.12.2021.
//

import Foundation

public protocol FeatureProvider {
    var features: [Feature] { get set }
    func set(features: [Feature])
}

public final class DefaultFeatureProvider: FeatureProvider {
    
    public var features: [Feature] = []

    public init() {}
    
    public func set(features: [Feature]) {
        self.features = features
    }
}
