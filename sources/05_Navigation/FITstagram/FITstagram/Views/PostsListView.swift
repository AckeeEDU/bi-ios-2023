//
//  PostsListView.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 17.10.2023.
//

import SwiftUI

struct PostsListView: View {
    private let posts = Post.postsMock
    @State private var isCommentsViewPresented = false
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(posts) { post in
                    PostView(post: post) {
                        isCommentsViewPresented = true
                    }
//                  These two variants are equal
//                  PostView(
//                      post: post,
//                      onCommentsTapped: {
//                          isCommentsViewPresented = true
//                      }
//                  )
                }
            }
        }
        .sheet(
            isPresented: $isCommentsViewPresented
        ) {
            CommentsView()
        }
        .onChange(of: isCommentsViewPresented) { oldValue, newValue in
            // You can see that dismissing view via drag gesture changes the state. This is possible thanks to binding that is passed to sheet.
            // print("[Old Value]:", oldValue, " [New Value]:", newValue)
        }
    }
}

#Preview {
    PostsListView()
}
