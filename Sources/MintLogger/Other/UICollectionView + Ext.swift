//
//  File.swift
//  
//
//  Created by Vladimir Golovkin on 20.12.2021.
//

import UIKit

extension UIView {
    static func className() -> String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(of type: T.Type, at index: IndexPath) -> T {
        let cell = self.dequeueReusableCell(withReuseIdentifier: type.className(),
                                                      for: index) as! T
        return cell
    }
    
    func dequeueReusableView<T: UICollectionReusableView>(of type: T.Type, kind: String, at index: IndexPath) -> T {
        let view = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.className(), for: index) as! T
        return view
    }
    
    func register<T: UICollectionViewCell>(of type: T.Type) {
        self.register(type, forCellWithReuseIdentifier: type.className())
    }
    
    func register<T: UICollectionReusableView>(
        of type: T.Type,
        kind: String) {
        self.register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: type.className())
    }
}
