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
    func fetchToggleValue(for key: String) -> String?
    func changeFeatureState(_ model: Feature)
    func changeFeatureToggleValue(_ model: Feature)
}

public final class DefaultFeatureRepository: FeatureRepository, Loggable {

    public var loggingTag: LogTag = .repository

    public func fetchFeatures() -> [Feature] {
        FeatureToggleProvider.shared.provider.features.map { feature -> Feature in
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

        let state = model.isActive ? "ON": "OFF"
        let message = "Feature \(model.key) is \(state)"
        log(.warning, message)
        log(.pulse, .warning, message)
    }

    public func changeFeatureToggleValue(_ model: Feature) {
        guard let toggleValue = model.toggleValue else { return }
        UserDefaults.standard.set(toggleValue, forKey: model.key)

        let message = "Feature \(model.key) has been changed to \(toggleValue)"
        log(.warning, message)
        log(.pulse, .warning, message)
    }

    public func fetchToggleValue(for key: String) -> String? {
        UserDefaults.standard.string(forKey: key)
    }
}
