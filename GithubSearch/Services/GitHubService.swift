//
//  GitHubService.swift
//  GithubSearch
//
//  Created by Anton Andrusenko on 25/09/2024.
//
import Foundation

class GitHubService {
    private let network = Network()
    private let baseURL = "https://api.github.com/search/repositories"
    
    func searchRepositories(query: String) async throws -> [Repository] {
        guard let url = URL(string: "\(baseURL)?q=\(query)") else {
            throw URLError(.badURL)
        }
        
        let searchResult: RepositoriesSearchResult = try await network.fetchData(url: url)
        return searchResult.items
    }
}
