//
//  MyProfileView.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 24.10.2023.
//

import SwiftUI

struct MyProfileView: View {
    
    // MARK: - Private properties
    
    private let name = "John Ackeeseed"
    private let description = "iOS nerd 🤓"
    
    // MARK: - UI
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    profileBadge
                        .padding(.leading, 16)
                    
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
    }
    
    // MARK: - Private helpers
    
    private var profileBadge: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image("badge")
              .resizable()
              .frame(width: 80, height: 80)
              .foregroundColor(.white)
              .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .fontWeight(.bold)
                
                Text(description)
                    .fontWeight(.regular)
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
