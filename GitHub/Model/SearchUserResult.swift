//
//  User.swift
//  GitHub
//
//  Created by Jose Pinto on 08/12/2021.
//

import Foundation

struct SearchUserResult: Decodable, Hashable {
    let login: String
    let avatarUrl: String
}
