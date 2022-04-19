//
//  LoadableViewCell.swift
//  
//
//  Created by Vladimir Golovkin on 20.12.2021.
//

import UIKit

open class LoadableViewCell: UICollectionViewCell {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    open func setup() {
    }
}
