//
//  Repository.swift
//  GithubSearch
//
//  Created by Anton Andrusenko on 25/09/2024.
//

import Foundation

struct Repository: Identifiable, Decodable {
    struct Owner: Decodable {
        let avatar_url: URL
    }
    
    let id: Int
    let name: String
    let description: String?
    let owner: Owner
}

struct RepositoriesSearchResult: Decodable {
    let items: [Repository]
}
