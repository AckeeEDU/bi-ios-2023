//
//  MyProfileView.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 24.10.2023.
//

import SwiftUI

// TODO: Save to USerDefaults

enum MyProfileViewDestination: Hashable {
    case edit
//    case setting
//    case followers
//    case following
}

var myUsername: String {
    // TODO: Will be introduced during lecture no. 10
    UserDefaults.custom.string(forKey: "myUsername") ?? ""
}

struct MyProfileView: View {
    
    // MARK: - Private properties
    
    private let description = "iOS nerd 🤓"
    // TODO: Will be introduced during lecture no. 10
    @AppStorage("myUsername", store: .custom) var username = ""
    @State private var path = NavigationPath()
    
    // MARK: - UI
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(alignment: .leading) {
                    headerView
                        .padding(.horizontal, 16)
                    
                    LazyVGrid(
                        columns: [
                            GridItem(spacing: 1),
                            GridItem(spacing: 1),
                            GridItem(spacing: 1)
                        ],
                        spacing: 1
                    ) {
                        ForEach(0..<21) { _ in
                            Rectangle()
                                .fill(.gray)
                                .aspectRatio(1, contentMode: .fill)
                                .overlay {
                                    RemoteImage(
                                        url: URL(string: "https://loremflickr.com/640/360")!
                                    )
                                }
                                .clipped()
                        }
                    }
                    .padding(.top, 24)
                }
            }
            .navigationDestination(
                for: MyProfileViewDestination.self
            ) { dest in
                switch dest {
                case .edit:
                    EditMyProfileView(
                        usernameText: username,
                        onSaveDismiss: { newUsername in
                            username = newUsername
                            path.removeLast()
                        }
                    )
                }
            }

        }
    }
    
    // MARK: - Private helpers
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center, spacing: 0) {
                Image("badge")
                  .resizable()
                  .frame(width: 80, height: 80)
                  .foregroundColor(.white)
                  .clipShape(Circle())
                
                Spacer()
                
                HStack(spacing: 0) {
                    profileStatsView(count: 1028, title: "Posts")
                    
                    Spacer()
                    
                    profileStatsView(count: 12_069, title: "Followers")
                    
                    Spacer()
                    
                    profileStatsView(count: 3, title: "Following")
                }
                .padding(.horizontal, 16)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(username)
                    .fontWeight(.bold)
                
                Text(description)
                    .fontWeight(.regular)
            }
            
            HStack {
                Button {
                    path.append(MyProfileViewDestination.edit)
                } label: {
                    Text("Upravit")
                }
            }
        }
    }
    
    private func profileStatsView(count: Int, title: String) -> some View {
        VStack(spacing: 0) {
            Text(String(count))
                .fontWeight(.bold)
            
            Text(title)
                .fontWeight(.regular)
        }
    }
}

// MARK: - Previews

#Preview {
    MyProfileView()
}
