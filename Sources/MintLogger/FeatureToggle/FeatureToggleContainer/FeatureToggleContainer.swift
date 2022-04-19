//
//  FeatureToggleContainer.swift
//  
//
//  Created by Vladimir Golovkin on 20.12.2021.
//

import Foundation

public final class FeatureToggleContainer {
    public static var shared: FeatureToggleContainer = .init()
    
    public private(set) var provider: FeatureProvider = DefaultFeatureProvider()
    public private(set) var service: FeatureService = DefaultFeatureService()
    
    @discardableResult
    public func set(service: FeatureService) -> FeatureToggleContainer {
        self.service = service
        return self
    }
    
    @discardableResult
    public func set(provider: FeatureProvider) -> FeatureToggleContainer {
        self.provider = provider
        return self
    }
    
    public func fetchState(for key: String) -> Bool {
        service.fetchFeatureState(for: key)
    }
}
