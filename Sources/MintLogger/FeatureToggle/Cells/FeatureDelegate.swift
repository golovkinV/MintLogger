//
//  FeatureDelegate.swift
//  
//
//  Created by Vladimir Golovkin on 20.12.2021.
//

import Foundation

public protocol FeatureDelegate: AnyObject {
    func changeState(_ model: Feature?)
}
