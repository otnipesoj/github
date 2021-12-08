//
//  GHFollowerItemView.swift
//  GitHub
//
//  Created by Jose Pinto on 08/12/2021.
//

import UIKit

class GHFollowerItemView: GHItemInfoGroupView {

    override init(user: User) {
        super.init(user: user)
        configureItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers ?? 0)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following ?? 0)
    }
}
