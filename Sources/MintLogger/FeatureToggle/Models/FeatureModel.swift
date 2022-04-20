//
//  FeatureModel.swift
//  
//
//  Created by Vladimir Golovkin on 17.12.2021.
//

import Foundation   

public enum FeatureType {
    case `switch`, contextMenu(items: [ContextMenuItem])
}

public protocol Feature {
    var key: String { get }
    var title: String { get }
    var type: FeatureType { get }
    var isActive: Bool { get set }
    var toggleValue: String? { get set }
}

public final class FeatureModel: Feature {
    public let key: String
    public let title: String
    public let type: FeatureType
    public var isActive: Bool = false
    public var toggleValue: String?

    public init(key: String, title: String, type: FeatureType) {
        self.key = key
        self.title = title
        self.type = type
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
