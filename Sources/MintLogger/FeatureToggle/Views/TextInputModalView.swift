//
//  TextInputModalView.swift
//
//
//  Created by Vladimir Golovkin on 01.06.2024.
//

import SwiftUI

struct TextInputModalView: View {
    let feature: TextInputFeature
    let viewModel: FeatureToggleViewModel
    @State private var inputText: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                TextField(feature.placeholder, text: $inputText)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 8.0)
            }
            Button("Готово") {
                viewModel.isPresented = false
                feature.didTapContinue(inputText)
            }
        }
    }
}
