//
//  UserDetailView.swift
//  GitHubUsers
//
//  Created by Nyan Lin Tun on 08/08/2025.
//

import SwiftUI

struct UserDetailView: View {
    @State var user: GitHubUser

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    AsyncImage(url: URL(string: user.avatarUrl)) { image in
                        image.resizable()
                            .scaledToFit()
                    } placeholder: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.gray)
                    }
                    .frame(width: 140, height: 140)
                    .clipShape(Circle())

                    Text(user.name)
                        .font(.title)
                        .bold()
                    HStack {
                        Text("Followers: 0")
                        Spacer()
                        Text("Following: 0")
                    }
                    .foregroundStyle(Color.gray)

                    Text("Repositories")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()

//                    ForEach(user.repositories) { repository in
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text(repository.name)
//                                .font(.headline)
//                                .foregroundStyle(Color.blue)
//
//                            HStack {
//                                Text(repository.language)
//                                    .font(.subheadline)
//
//                                Spacer()
//
//                                Image(systemName: "star.fill")
//                                    .foregroundStyle(Color.gray)
//
//                                Text("\(repository.stars)")
//                            }
//
//                            Text(repository.description)
//                        }
//                        .padding(.vertical)
//
//                        Divider()
//                    }
                }
                .padding()
            }
            .navigationTitle(user.login)
            .task {
                try? await getUserDetail()
            }
        }
    }
    
    @MainActor
    func getUserDetail() async throws {
        let urlString = "https://api.github.com/users/\(user.login)"
        guard let url = URL(string: urlString) else {
            return
        }
        let (data, _) = try await URLSession.shared.data(from: url)
       
        let decoder = JSONDecoder()
        let userDetail = try decoder.decode(GitHubUserResponse.self, from: data)
        self.user = GithubUserMapper().map(input: userDetail)
    }
}

#Preview {
    UserDetailView(user: .init(id: 1, login: "Hello", avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4", name: "World"))
}
