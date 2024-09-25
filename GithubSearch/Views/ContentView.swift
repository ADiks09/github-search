//
//  ContentView.swift
//  GithubSearch
//
//  Created by Anton Andrusenko on 25/09/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search GitHub repositories", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        
                        Spacer()
                    }
                )
        }
    }
}


struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: .constant("git"))
                    .padding()
                
                Spacer()

                List(["1", "2", "3", "4", "5", "6", "7", "8", "9"], id: \.self) { _ in
                    RepositoryRowView()
                }
            }
            .navigationTitle("GitHub Search")
        }
    }
}

struct RepositoryRowView: View {
    var body: some View {
        HStack {
            AsyncImage(url: URL("https://avatars.githubusercontent.com/u/42816656?v=4")!) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading) {
                Text("Swift ui us the best")
                    .bold()
                
                Text("sadj klajlkds laksjdklaj lksjdklaj dlka as lhdashdkjh adha djks")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    ContentView()
}
