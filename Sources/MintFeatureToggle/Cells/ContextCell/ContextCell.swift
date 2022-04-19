//
//  ContextCell.swift
//  
//
//  Created by Vladimir Golovkin on 20.12.2021.
//

import UIKit

final class ContextCell: BaseFeatureCell {
    
    private(set) lazy var titleLabel = UILabel().apply {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.numberOfLines = 1
    }
    
    override func setup() {
        addSubview(titleLabel)
        super.setup()
    }
    
    override func configure(_ model: Feature) -> BaseFeatureCell {
        super.configure(model)
        titleLabel.text = model.title
        return self
    }
    
    override func layout() {
        titleLabel.pin
            .vertically()
            .horizontally(16)
            .sizeToFit(.width)
    }
}
