//
//  FeatureModel.swift
//  
//
//  Created by Vladimir Golovkin on 17.12.2021.
//

import Foundation   

public class FeatureModel: Feature {
    public let key: String
    public let title: String

    public init(
        key: String,
        title: String
    ) {
        self.key = key
        self.title = title
    }
}

public final class SwitchModelImp: FeatureModel, SwitchFeature {
    public let didSwitched: ((Bool) -> Void)?
    public var isActive: Bool = false

    public init(
        key: String,
        title: String,
        isActive: Bool = false,
        didSwitched: ((Bool) -> Void)? = nil
    ) {
        self.isActive = isActive
        self.didSwitched = didSwitched
        super.init(key: key, title: title)
    }
}

public final class ContextFeature: FeatureModel, ValueFeature {
    public var toggleValue: String?
    public let items: [ContextMenuItem]
    
    public init(key: String, title: String, items: [ContextMenuItem]) {
        self.items = items
        super.init(key: key, title: title)
    }
}

public struct ContextMenuItem {
    public let title: String
    public let toggleValue: String
    public let didSelected: (() -> Void)?
    public let isDefault: Bool

    public init(
        title: String,
        toggleValue: String,
        isDefault: Bool = false,
        didSelected: (() -> Void)? = nil
    ) {
        self.title = title
        self.toggleValue = toggleValue
        self.isDefault = isDefault
        self.didSelected = didSelected
    }
}

extension ContextMenuItem: Equatable {
    public static func == (lhs: ContextMenuItem, rhs: ContextMenuItem) -> Bool {
        lhs.toggleValue == rhs.toggleValue
    }
}
