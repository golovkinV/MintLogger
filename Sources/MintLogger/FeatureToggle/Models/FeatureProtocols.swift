//
//  FeatureProtocols.swift
//  
//
//  Created by Vladimir Golovkin on 14.05.2022.
//

import Foundation

public protocol Feature: AnyObject {
    var key: String { get }
    var title: String { get }
}

public protocol SwitchFeature: Feature {
    var isActive: Bool { get set }
    var didSwitched: ((Bool) -> Void)? { get }
}

public protocol ValueFeature: Feature {
    var toggleValue: String? { get set }
    var items: [ContextMenuItem] { get }
}
