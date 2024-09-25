//
//  RepositoryRowView.swift
//  GithubSearch
//
//  Created by Anton Andrusenko on 25/09/2024.
//

import SwiftUI

struct RepositoryRowView: View {
    let repository: Repository
    
    var body: some View {
        HStack {
            AsyncImage(url: repository.owner.avatar_url) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
                    .frame(width: 50, height: 50)
            }
            
            VStack(alignment: .leading) {
                Text(repository.name)
                    .bold()
                
                if let description = repository.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
