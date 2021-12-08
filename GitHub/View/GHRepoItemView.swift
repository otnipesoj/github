//
//  GHRepoItemView.swift
//  GitHub
//
//  Created by Jose Pinto on 08/12/2021.
//

import UIKit

class GHRepoItemView: GHItemInfoGroupView {

    override init(user: User) {
        super.init(user: user)
        configureItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos ?? 0)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists ?? 0)
    }
}
