//
//  ReusableView.swift
//  GitHub
//
//  Created by Jose Pinto on 08/12/2021.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell : ReusableView { }
extension UITableViewCell : ReusableView { }
