//
//  UIScrollView+Ext.swift
//  GitHub
//
//  Created by Jose Pinto on 08/12/2021.
//

import UIKit

extension UIScrollView {
    func scrollToTop(animated: Bool) {
        var topContentOffset: CGPoint
        if #available(iOS 11.0, *) {
            topContentOffset = CGPoint(x: -safeAreaInsets.left, y: -safeAreaInsets.top)
        } else {
            topContentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top)
        }
        setContentOffset(topContentOffset, animated: animated)
    }
}
