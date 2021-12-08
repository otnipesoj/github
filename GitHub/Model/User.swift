//
//  User.swift
//  GitHub
//
//  Created by Jose Pinto on 08/12/2021.
//

import Foundation

struct User: Decodable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
}
