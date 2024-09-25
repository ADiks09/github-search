//
//  SearchBarView.swift
//  GithubSearch
//
//  Created by Anton Andrusenko on 25/09/2024.
//

import SwiftUI

struct SearchBarView: View {
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
