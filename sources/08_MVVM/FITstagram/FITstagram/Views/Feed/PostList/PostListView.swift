//
//  PostsListView.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 17.10.2023.
//

import SwiftUI

/// PostsListView uses iOS13+ changes observation system
struct PostListView: View {
    @StateObject var viewModel: PostListViewModel = PostListViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ScrollView {
                PostListContentView(
                    viewModel: viewModel
                )
                    .padding(.top, 8)
            }
            //            .sheet(
            //                isPresented: $isCommentsViewPresented
            //            ) {
            //                CommentsView(
            //                    isCommentsViewPresented: $isCommentsViewPresented
            //                )
            //                .presentationDetents([.fraction(0.8)])
            //                .presentationDragIndicator(.visible)
            //            }
            .fullScreenCover(
                item: $viewModel.presentedCommentsPost
            ) { post in
                CommentsView(
                    viewModel:
                        CommentsViewModel(
                            postID: post.id,
                            onCommentsClose: {
                                // In the current implementation, we expect that it will not be called elsewhere than from the main thread. But we'll cover this just in case.
                                DispatchQueue.main.async {
                                    viewModel.hideCommentsList()
                                }
                            }
                        )
                )
            }
            .navigationDestination(
                for: [User].self,
                destination: { likes in
                    LikesView(likes: likes)
                }
            )
            .navigationDestination(for: User.self) {
                UserDetailView(user: $0)
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        viewModel.showGallery()
                    } label: {
                        Image(systemName: "photo.stack.fill")
                    }
                    .tint(.pink)
                    
                    Button {
                        viewModel.openCamera()
                    } label: {
                        Image(systemName: "camera")
                    }
                    .tint(.pink)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Feed")
            .task {
                await viewModel.fetchPosts()
            }
        }
    }
}

extension PostListView {
    struct PostListContentView: View {
        /// @ObservedObject: PostListContentView is just watching, viewModel is passed by reference
        @ObservedObject var viewModel: PostListViewModel
        
        var body: some View {
            LazyVStack(spacing: 24) {
                ForEach(viewModel.posts) { post in
                    PostView(post: post) {
                        viewModel.showCommentsList(post)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PostListView(viewModel: .init())
    }
}
