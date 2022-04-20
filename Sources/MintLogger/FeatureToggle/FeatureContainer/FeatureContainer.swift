//
//  FeatureContainer.swift
//  
//
//  Created by Vladimir Golovkin on 20.12.2021.
//

import Foundation

public protocol FeatureContainer {
    var features: [Feature] { get }
    func set(features: [Feature])
}

public final class DefaultFeatureContainer: FeatureContainer {
    
    public var features: [Feature] = []

    public init() {}
    
    public func set(features: [Feature]) {
        self.features = features
    }
}
