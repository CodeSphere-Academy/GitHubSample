//
//  GitHubUser.swift
//  GitHubUsers
//
//  Created by Nyan Lin Tun on 03/08/2025.
//

import Foundation

struct GitHubUserResponse: Identifiable, Decodable {
    let id: Int
    let login: String
    let avatar_url: String
    let name: String?
}

struct GitHubUser: Identifiable {
    let id: Int
    let login: String
    let avatarUrl: String
    let name: String
}


struct GitHubRepository: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let language: String
    let stars: Int
}

let sampleUsers: [GitHubUserResponse] = [
    GitHubUserResponse(
        id: 1,
        login: "mojombo",
        avatar_url: "https://avatars.githubusercontent.com/u/1?v=4",
        name: "Mojo"
    )
]
