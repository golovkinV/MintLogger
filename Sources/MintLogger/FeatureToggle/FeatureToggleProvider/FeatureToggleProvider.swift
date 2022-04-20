//
//  FeatureToggleProvider.swift
//  
//
//  Created by Vladimir Golovkin on 20.12.2021.
//

import Foundation

public final class FeatureToggleProvider {
    public static let shared: FeatureToggleProvider = .init()
    
    public private(set) var container: FeatureContainer = DefaultFeatureContainer()
    private(set) var service: FeatureService = DefaultFeatureService()
    
    @discardableResult
    public func set(service: FeatureService) -> FeatureToggleProvider {
        self.service = service
        return self
    }
    
    @discardableResult
    public func set(provider: FeatureContainer) -> FeatureToggleProvider {
        self.container = provider
        return self
    }
    
    public func fetchState(for key: String) -> Bool {
        service.fetchFeatureState(for: key)
    }

    public func fetchToggleValue(for key: String) -> String? {
        service.fetchToggleValue(for: key)
    }
}
