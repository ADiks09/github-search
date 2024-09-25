//
//  RepositoryDetailView.swift
//  GithubSearch
//
//  Created by Anton Andrusenko on 25/09/2024.
//

import SwiftUI

struct RepositoryDetailView: View {
    let repository: Repository
    
    @State var showSafari: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                AsyncImage(url: repository.owner.avatar_url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(repository.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("by \(repository.owner.login)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }

            if let description = repository.description {
                Text(description)
                    .font(.body)
            }
            
            Divider()
            
            HStack {
                Label("\(repository.stargazers_count)", systemImage: "star")
                Label("\(repository.forks_count)", systemImage: "tuningfork")
                Label("\(repository.open_issues_count)", systemImage: "exclamationmark.triangle")
            }
            .font(.headline)

            if let license = repository.license {
                HStack {
                    Text("License: \(license.name)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            if let lastUpdated = formatDate(dateString: repository.updated_at) {
                Text("Last updated: \(lastUpdated)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {
                showSafari = true
            } label: {
                Text("Open in Browser")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.blue)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue, lineWidth: 2)
                    )
            }
        }
        .padding()
        .navigationTitle(repository.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showSafari) {
            if let url = URL(string: "https://github.com/\(repository.owner.login)/\(repository.name)") {
                SafariView(url: url)
            }
        }
    }

    private func formatDate(dateString: String) -> String? {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return nil
    }
}
