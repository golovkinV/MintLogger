//
//  FeatureViewRow.swift
//  
//
//  Created by Vladimir Golovkin on 11.08.2022.
//

import SwiftUI

struct FeatureViewRow: View {

    let feature: SwitchFeature
    let viewModel: FeatureToggleViewModel

    var body: some View {
        VStack {
            let isOnBinding = Binding(get: {
                feature.isActive
            }, set: {
                feature.isActive = $0
                feature.didSwitched?($0)
                viewModel.changeFeatureState(feature)
            })

            Toggle(feature.title, isOn: isOnBinding)
                .font(Font.system(size: 16, weight: .medium))
        }
    }
}

struct FeatureViewRowPreviews: PreviewProvider {
    static var previews: some View {
        FeatureViewRow(
            feature: SwitchModelImp(key: "TEST_FEATURE", title: "Test title"),
            viewModel: .init()
        )
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
