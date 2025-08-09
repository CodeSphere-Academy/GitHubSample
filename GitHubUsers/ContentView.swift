//
//  ContentView.swift
//  GitHubUsers
//
//  Created by Nyan Lin Tun on 03/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var githubUsers: [GitHubUser] = []
    var body: some View {
        NavigationStack {
            List(githubUsers) { user in
                NavigationLink(destination: UserDetailView(user: user)) {
                    HStack {
                        AsyncImage(url: URL(string: user.avatarUrl)) { image in
                            image.resizable()
                                .scaledToFit()
                        } placeholder: {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.gray)
                        }
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())

                        Text(user.login)
                            .font(.body)
                    }
                }
            }
            .navigationTitle("GitHub Users")
            .task {
                // only one time execution
                try? await getUsers()
            }
        }
    }
    
    @MainActor
    func getUsers() async throws {
        let urlString = "https://api.github.com/users"
        guard let url = URL(string: urlString) else {
            return
        }
        let (data, _) = try await URLSession.shared.data(from: url)
       
        let decoder = JSONDecoder()
        let users = try decoder.decode([GitHubUserResponse].self, from: data)
        self.githubUsers = GitHubUsersMapper().map(input: users)
    }
}

#Preview {
    ContentView()
}
