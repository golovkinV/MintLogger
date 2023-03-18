//
//  ContextMenuViewRow.swift
//  
//
//  Created by Vladimir Golovkin on 11.08.2022.
//

import SwiftUI

struct ContextMenuViewRow: View {

    @State private var toggleValue: String?
    let feature: ValueFeature
    let viewModel: FeatureToggleViewModel

    var body: some View {
        HStack {
            Text(feature.title)
                .font(Font.system(size: 16, weight: .medium))
                .contextMenu {
                    ForEach(feature.items, id: \.title) { item in
                        Button {
                            toggleValue = item.toggleValue
                            feature.toggleValue = item.toggleValue
                            viewModel.changeFeatureToggleValue(feature)
                            item.didSelected?()
                        } label: {
                            Text(item.title)
                        }
                    }
                }

            Text(toggleValue ?? feature.toggleValue ?? .init())
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(Font.system(size: 16, weight: .regular))
                .foregroundColor(.gray)
        }
    }
}

struct ContextMenuViewRowPreviews: PreviewProvider {
    static var previews: some View {
        ContextMenuViewRow(
            feature: ContextFeature(
                key: "TEST_CONTEXT",
                title: "Test context",
                items: [
                    .init(title: "Option 1", toggleValue: "Option 1")
                ]
            ),
            viewModel: .init()
        )
    }
}
