//
//  FeatureToggleAssembly.swift
//  
//
//  Created by Vladimir Golovkin on 17.12.2021.
//

import SwiftUI
import UIKit

public final class FeatureToggleAssembly {
    public class func createModule() -> UIViewController {
        let viewModel = FeatureToggleViewModel()
        let hc = UIHostingController(rootView: FeatureToggleView(viewModel: viewModel))
        hc.title = "Feature"
        return hc
    }
}
