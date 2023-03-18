//
//  FeatureToggleProvider.swift
//  
//
//  Created by Vladimir Golovkin on 20.12.2021.
//

import Foundation

public final class FeatureToggleProvider {
    public static let shared: FeatureToggleProvider = .init()
    
    private(set) var container: FeatureContainer = DefaultFeatureContainer()
    private(set) var service: FeatureService = DefaultFeatureService()
    
    @discardableResult
    public func set(service: FeatureService) -> FeatureToggleProvider {
        self.service = service
        return self
    }
    
    @discardableResult
    public func set(container: FeatureContainer) -> FeatureToggleProvider {
        self.container = container
        return self
    }

    @discardableResult
    public func set(features: [Feature]) -> FeatureToggleProvider {
        container.set(features: features)
        saveDefaultValues()
        return self
    }

    public func fetchState(for key: String) -> Bool {
        service.fetchFeatureState(for: key)
    }

    public func fetchToggleValue(for key: String) -> String? {
        service.fetchToggleValue(for: key)
    }

    // MARK: - Private

    private func saveDefaultValues() {
        container.features.forEach { saveFeatureIfCan($0) }
    }

    private func saveFeatureIfCan(_ feature: Feature) {
        guard !isKeyInUserDefaults(feature.key) else { return }

        switch feature {
        case let value as SwitchFeature:
            saveSwitchFeature(value)
        case let value as ValueFeature:
            saveValueFeature(value)
        default:
            break
        }
    }

    private func saveSwitchFeature(_ feature: SwitchFeature) {
        service.changeFeatureState(feature)
    }

    private func saveValueFeature(_ feature: ValueFeature) {
        let items = feature.items
        
        if let defaultItem = items.first(where: { $0.isDefault }) {
            feature.toggleValue = defaultItem.toggleValue
        } else {
            feature.toggleValue = items.first?.toggleValue
        }

        service.changeFeatureToggleValue(feature)
    }

    private func isKeyInUserDefaults(_ key: String) -> Bool {
        UserDefaults.standard.object(forKey: key) != nil
    }
}
