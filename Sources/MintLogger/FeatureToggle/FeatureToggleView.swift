//
//  FeatureToggleView.swift
//  
//
//  Created by Vladimir Golovkin on 08.08.2022.
//

import SwiftUI

struct FeatureToggleView: View {

    @ObservedObject private var viewModel: FeatureToggleViewModel

    init(viewModel: FeatureToggleViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List(viewModel.items, id: \.key) { feature in
            switch feature {
            case let value as SwitchFeature:
                FeatureViewRow(feature: value, viewModel: viewModel)
            case let value as ValueFeature:
                ContextMenuViewRow(feature: value, viewModel: viewModel)
            default:
                Text(feature.title)
            }
        }
        .onAppear {
            viewModel.fetchFeatures()
        }
    }
}

struct FeatureToggleViewPreviews: PreviewProvider {
    static var previews: some View {
        FeatureToggleView(viewModel: .init())
    }
}
