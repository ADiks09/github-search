//
//  SearchRepositoriesFeature.swift
//  GithubSearch
//
//  Created by Anton Andrusenko on 25/09/2024.
//

import SwiftUI
import Combine

@MainActor
final class SearchRepositoriesFeature: ObservableObject {
    enum State {
        case idle
        case loaded([Repository])
        case loading
        case error(message: String)
    }
    
    @Published var state: State = .idle
    @Published var input: String = ""
    
    private let gitHubService = GitHubService()
    
    private var debounceTimer: Task<Void, Error>?
    private var bag: Set<AnyCancellable> = .init()
    
    init() {
        $input.sink { [weak self] value in
            self?.runSearch(query: value)
        }
        .store(in: &bag)
    }

    private func runSearch(query: String) {
        guard !query.isEmpty else {
            state = .idle
            debounceTimer?.cancel()
            return
        }
        debounceTimer?.cancel()
        debounceTimer = Task {
            try await Task.sleep(nanoseconds: 1_000_000_000) // 1sec
            if Task.isCancelled {
                return
            }
            await performSearch(query: query)
        }
    }
    
    private func performSearch(query: String) async {
        state = .loading
        do {
            let repositories = try await gitHubService.searchRepositories(query: query)
            state = .loaded(repositories)
        } catch {
            let errorMessage = error.localizedDescription
            state = .error(message: errorMessage)
        }
    }
}
