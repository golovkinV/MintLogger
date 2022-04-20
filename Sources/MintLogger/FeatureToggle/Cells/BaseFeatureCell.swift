//
//  BaseFeatureCell.swift
//  
//
//  Created by Vladimir Golovkin on 20.12.2021.
//

import UIKit

class BaseFeatureCell: LoadableViewCell {
    private(set) weak var delegate: FeatureDelegate?
    var model: Feature?
    
    override func setup() {
        super.setup()
        setupPublishers()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    @discardableResult
    func setDelegate(_ delegate: FeatureDelegate) -> BaseFeatureCell {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    func configure(_ model: Feature) -> BaseFeatureCell {
        self.model = model
        // Override
        return self
    }
    
    func setupPublishers() {}
    
    func layout() {}
}
