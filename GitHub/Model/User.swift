//
//  User.swift
//  GitHub
//
//  Created by Jose Pinto on 08/12/2021.
//

import Foundation

struct User: Decodable, Hashable {
    let uuid = UUID()
    let id: Int
    let login: String
    let avatarUrl: String
    let name: String?
    let company: String?
    let location: String?
    let blog: String?
    let bio: String?
    let publicRepos: Int?
    let publicGists: Int?
    let htmlUrl: String?
    let following: Int?
    let followers: Int?
    let createdAt: Date?
    
    private enum CodingKeys : String, CodingKey { case id, login, avatarUrl, name, company, location, blog, bio, publicRepos, publicGists, htmlUrl, following, followers, createdAt }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
