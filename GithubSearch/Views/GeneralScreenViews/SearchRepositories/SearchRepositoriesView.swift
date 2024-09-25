//
//  SearchRepositoriesView.swift
//  GithubSearch
//
//  Created by Anton Andrusenko on 25/09/2024.
//

import SwiftUI

struct SearchRepositoriesView: View {
    @StateObject var feature = SearchRepositoriesFeature()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $feature.input)
                    .padding()
                
                Spacer()

                switch feature.state {
                case .idle:
                    Text("Enter query to start searching")
                case .loaded(let repositories):
                    List(repositories) { repository in
                        RepositoryRowView(repository: repository)
                    }
                case .loading:
                    ProgressView("Searching...")
                case .error(let message):
                    Text("Error: \(message)")
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
            .navigationTitle("GitHub Search")
        }
    }
}

#Preview {
    SearchRepositoriesView()
}
