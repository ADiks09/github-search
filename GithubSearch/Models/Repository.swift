//
//  Repository.swift
//  GithubSearch
//
//  Created by Anton Andrusenko on 25/09/2024.
//

import Foundation

struct Repository: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String?
    let owner: Owner
    let stargazers_count: Int
    let forks_count: Int
    let open_issues_count: Int
    let updated_at: String
    let license: License?

    struct Owner: Decodable {
        let login: String
        let avatar_url: URL
    }

    struct License: Decodable {
        let name: String
    }
}

struct RepositoriesSearchResult: Decodable {
    let items: [Repository]
}
