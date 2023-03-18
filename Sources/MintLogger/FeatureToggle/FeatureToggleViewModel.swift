//
//  FeatureToggleViewModel.swift
//  
//
//  Created by Vladimir Golovkin on 08.08.2022.
//

import Foundation

final class FeatureToggleViewModel: ObservableObject {
    @Published var items: [Feature] = []

    func fetchFeatures() {
        items = FeatureToggleProvider.shared.service.fetchFeatures()
    }

    func changeFeatureState(_ model: SwitchFeature) {
        FeatureToggleProvider.shared.service.changeFeatureState(model)
    }

    func changeFeatureToggleValue(_ model: ValueFeature) {
        FeatureToggleProvider.shared.service.changeFeatureToggleValue(model)
    }
}
