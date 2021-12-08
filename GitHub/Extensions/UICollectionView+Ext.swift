//
//  UICollectionView+Ext.swift
//  GitHub
//
//  Created by Jose Pinto on 08/12/2021.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath)
        return cell as! T
    }
    
    func scrollToTop(animated: Bool) {
        let topContentOffset = CGPoint(x: -safeAreaInsets.left, y: -safeAreaInsets.top)
        setContentOffset(topContentOffset, animated: animated)
    }
}
