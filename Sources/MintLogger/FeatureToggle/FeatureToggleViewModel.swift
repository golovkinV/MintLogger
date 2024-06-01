//
//  FeatureToggleViewModel.swift
//  
//
//  Created by Vladimir Golovkin on 08.08.2022.
//

import UIKit
import SwiftUI
import Combine
import FittedSheets

final class FeatureToggleViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    @Published var items: [Feature] = []
    @Published var isPresented = false
    
    
    init() {
        $isPresented
            .dropFirst()
            .sink(receiveValue: { result in
                if !result {
                    UINavigationController.topViewController?.dismiss(
                        animated: true
                    )
                }
            })
            .store(in: &cancellables)
    }
    
    func fetchFeatures() {
        items = FeatureToggleProvider.shared.service.fetchFeatures()
    }
    
    func showBottomSheet(_ model: TextInputItem) {
        let hc = UIHostingController(
            rootView: TextInputModalView(
                feature: model,
                viewModel: self
            )
        )
        let options: SheetOptions = SheetOptions(
            shrinkPresentingViewController: false
        )
        let sheetController = SheetViewController(
            controller: hc,
            sizes: [.percent(0.25)],
            options: options
        )
        sheetController.autoAdjustToKeyboard = true
        UINavigationController.topViewController?.present(
            sheetController,
            animated: true
        )
    }
    
    func changeFeatureState(_ model: SwitchFeature) {
        FeatureToggleProvider.shared.service.changeFeatureState(model)
    }

    func changeFeatureToggleValue(_ model: ValueFeature) {
        FeatureToggleProvider.shared.service.changeFeatureToggleValue(model)
    }
}
