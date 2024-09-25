//
//  Network.swift
//  GithubSearch
//
//  Created by Anton Andrusenko on 25/09/2024.
//

import Foundation

final class Network {
    func fetchData<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
