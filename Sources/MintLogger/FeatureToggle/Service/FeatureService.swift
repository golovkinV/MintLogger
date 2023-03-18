//
//  FeatureService.swift
//  
//
//  Created by Vladimir Golovkin on 17.12.2021.
//

import Foundation

public protocol FeatureService {
    func fetchFeatures() -> [Feature]
    func changeFeatureState(_ model: SwitchFeature)
    func fetchFeatureState(for key: String) -> Bool
    func fetchToggleValue(for key: String) -> String?
    func changeFeatureToggleValue(_ model: ValueFeature)
}

public final class DefaultFeatureService: FeatureService {
    
    private let featureRepository: FeatureRepository = DefaultFeatureRepository()
    
    public func fetchFeatures() -> [Feature] {
        featureRepository.fetchFeatures()
    }
    
    public func changeFeatureState(_ model: SwitchFeature) {
        featureRepository.changeFeatureState(model)
    }

    public func changeFeatureToggleValue(_ model: ValueFeature) {
        featureRepository.changeFeatureToggleValue(model)
    }

    public func fetchFeatureState(for key: String) -> Bool {
        featureRepository.fetchFeatureState(for: key)
    }

    public func fetchToggleValue(for key: String) -> String? {
        featureRepository.fetchToggleValue(for: key)
    }
}
