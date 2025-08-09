//
//  GitHubUserMapper.swift
//  GitHubUsers
//
//  Created by Nyan Lin Tun on 9/8/25.
//

import Foundation

protocol ModelMapper {
    associatedtype Input
    associatedtype Output
    func map(input: Input) -> Output
}

struct GithubUserMapper: ModelMapper {
    typealias Input = GitHubUserResponse
    typealias Output = GitHubUser
    func map(input: GitHubUserResponse) -> GitHubUser {
        GitHubUser(
            id: input.id,
            login: input.login,
            avatarUrl: input.avatar_url,
            name: input.name ?? ""
        )
    }
}

struct GitHubUsersMapper: ModelMapper {
    typealias Input = [GitHubUserResponse]
    typealias Output = [GitHubUser]
    func map(input: [GitHubUserResponse]) -> [GitHubUser] {
        input.map {
            GithubUserMapper().map(input: $0)
        }
    }
    
}
