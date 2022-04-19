//
//  FeatureRepository.swift
//  
//
//  Created by Vladimir Golovkin on 17.12.2021.
//

import Foundation

public protocol FeatureRepository {
    func fetchFeatures() -> [Feature]
    func fetchFeatureState(for key: String) -> Bool
    func changeFeatureState(_ model: Feature)
}

public final class DefaultFeatureRepository: FeatureRepository {
    
    public func fetchFeatures() -> [Feature] {
        FeatureToggleContainer.shared.provider.features.map { feature -> Feature in
            var feature = feature
            feature.isActive = fetchFeatureState(for: feature.key)
            return feature
        }
    }
    
    public func fetchFeatureState(for key: String) -> Bool {
        UserDefaults.standard.bool(forKey: key)
    }
        
    public func changeFeatureState(_ model: Feature) {
        UserDefaults.standard.set(model.isActive, forKey: model.key)
    }
}
