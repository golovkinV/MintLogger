//
//  FeatureModel.swift
//  
//
//  Created by Vladimir Golovkin on 17.12.2021.
//

import Foundation

public enum FeatureType: String {
    case `switch`, contextMenu
}

public protocol Feature {
    var key: String { get }
    var title: String { get }
    var type: FeatureType { get }
    var isActive: Bool { get set }
}

public final class FeatureModel: Feature {
    public var key: String
    public var title: String
    public var type: FeatureType
    public var isActive: Bool = false
    
    public init(key: String, title: String, type: FeatureType) {
        self.key = key
        self.title = title
        self.type = type
    }
}
