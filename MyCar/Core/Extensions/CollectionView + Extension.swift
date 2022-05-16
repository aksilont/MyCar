//
//  CollectionView + Extension.swift
//  MyCar
//
//  Created by Alex Larin on 13.05.2022.
//

import UIKit

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(registerClass: T.Type) {
        let defaultReuseIdentifier = registerClass.defaultReuseIdentifier
        register(registerClass, forCellWithReuseIdentifier: defaultReuseIdentifier)
    }
    
    func registerWithNib<T: UICollectionViewCell>(registerClass: T.Type) {
        let defaultReuseIdentifier = registerClass.defaultReuseIdentifier
        let nib = UINib(nibName:  String(describing: registerClass.self), bundle: nil)
        register(nib, forCellWithReuseIdentifier: defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}

extension UICollectionViewCell: ReusableView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
