//
//  LikesView.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 17.10.2023.
//

import SwiftUI

struct LikesView: View {
    private let likes = Post.postMock.likes
    
    // MARK: - Body
    
    var body: some View {
        List {
            Section {
                ForEach(likes, id: \.username) {
                    Text($0.username)
                }
            } header: {
                Text("Likes")
            }
        }
    }
}

#Preview {
    LikesView()
}
