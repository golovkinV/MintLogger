//
//  FeatureCell.swift
//  
//
//  Created by Vladimir Golovkin on 20.12.2021.
//

import UIKit
import PinLayout
import CombineCocoa

final class FeatureSwitchCell: BaseFeatureCell {
    
    private var bag = CancelBag()
    
    private(set) lazy var titleLabel = UILabel().apply {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.numberOfLines = 1
    }
    
    private(set) lazy var modeSwith = UISwitch()
    
    override func setup() {
        [titleLabel, modeSwith].forEach {
            addSubview($0)
        }
        super.setup()
    }
    
    override func configure(_ model: Feature) -> BaseFeatureCell {
        super.configure(model)
        titleLabel.text = model.title
        modeSwith.isOn = model.isActive
        return self
    }
    
    override func setupPublishers() {
        modeSwith.isOnPublisher
            .sink(receiveValue: { [weak self] in
                self?.model?.isActive = $0
                let model = self?.model
                self?.delegate?.changeState(model)
            })
            .store(in: &bag)
    }
    
    override func layout() {
        modeSwith.pin
            .centerEnd()
            .marginRight(16)
        
        titleLabel.pin
            .centerRight(to: modeSwith.anchor.centerLeft)
            .marginRight(16)
            .left(16)
            .sizeToFit(.width)
    }
}
