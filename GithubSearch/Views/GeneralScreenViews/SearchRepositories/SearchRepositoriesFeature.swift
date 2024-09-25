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
    
    private var activeTask: Task<Void, Error>?
    private var bag: Set<AnyCancellable> = .init()
    
    init() {
        $input
            .removeDuplicates()
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] value in
                self?.runSearch(query: value)
            }
            .store(in: &bag)
    }

    private func runSearch(query: String) {
        guard !query.isEmpty else {
            state = .idle
            activeTask?.cancel()
            return
        }
        state = .loading
        activeTask?.cancel()
        activeTask = Task {
            await performSearch(query: query)
        }
    }
    
    private func performSearch(query: String) async {
        do {
            if Task.isCancelled {
                return
            }
            let repositories = try await gitHubService.searchRepositories(query: query)
            state = .loaded(repositories)
        } catch {
            let errorMessage = error.localizedDescription
            state = .error(message: errorMessage)
        }
    }
}
