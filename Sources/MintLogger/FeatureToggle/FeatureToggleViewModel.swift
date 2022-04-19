//
//  FeatureToggleViewModel.swift
//  
//
//  Created by Vladimir Golovkin on 17.12.2021.
//

import Foundation

public final class FeatureToggleViewModel {
    
    private var bag = CancelBag()
    
    public let input: Input = .init()
    public let output: Output = .init()
    
    public init() {
        setUpBindings()
    }
    
    func changeFeatureState(_ model: Feature) {
        FeatureToggleContainer.shared.service.changeFeatureState(model)
    }
    
    private func setUpBindings() {
        input.didLoad.publisher
            .sink { [weak self] _  in
                self?.fetchFeatures()
            }
            .store(in: &bag)
    }
    
    private func fetchFeatures() {
        output.items = FeatureToggleContainer.shared.service.fetchFeatures()
    }
}

public extension FeatureToggleViewModel {
    class Input {
        var didLoad = PublishedAction<Void>()
    }
    
    class Output {
        @PublishedProperty var items: [Feature] = []
    }
}
