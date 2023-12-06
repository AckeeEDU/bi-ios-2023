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
    @Environment(JSONAPIService.self) var jsonAPI
    
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
//                        }
            .fullScreenCover(
                item: $viewModel.presentedCommentsPost
            ) { post in
                CommentsView(
                    viewModel:
                        CommentsViewModel(
                            postID: post.id,
                            onCommentsClose: { changed in
                                if changed {
                                    viewModel.fetchPost(postID: post.id)
                                }
                                
                                viewModel.hideCommentsList()
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
            .navigationDestination(for: Post.self) { post in
                let detailVM = PostDetailViewModel(
                    postID: post.id,
                    jsonAPI: jsonAPI
                )
                PostDetailView(viewModel: detailVM)
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        viewModel.showGallery()
                    } label: {
                        Image(systemName: "photo.stack.fill")
                    }
                    
                    Button {
                        viewModel.openCamera()
                    } label: {
                        Image(systemName: "camera")
                    }
                }
            }
            .fullScreenCover(
                isPresented: $viewModel.isUsernameViewPresented,
                content: {
                    UsernameView(
                        isUsernameViewPresented: $viewModel.isUsernameViewPresented
                    )
                }
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Feed")
            .task {
                await viewModel.fetchPosts()
            }
            .onAppear {
                if myUsername.isEmpty {
                    viewModel.showUsernameView()
                }
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
                    PostView(
                        viewModel: .init(
                            post: post,
                            onCommentsTapped: {
                                viewModel.showCommentsList(post)
                            },
                            onPostUpdated: {
                                viewModel.fetchPost(postID: post.id)
                            }
                        )
                    )
                }
            }
        }
    }
    
    struct UsernameView: View {
        @State var text = ""
        @Binding var isUsernameViewPresented: Bool
        
        var body: some View {
            VStack(spacing: 8) {
                Spacer()
                
                Text("Fill in your username, otherwise you can't like or comment posts 😏")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField(
                    text: $text,
                    label: {
                        Text("Enter your username")
                    }
                )
                .textFieldStyle(.roundedBorder)
                
                Spacer()
                
                Button {
                    // TODO: Will be introduced during lecture no. 10
                    UserDefaults.custom.setValue(text, forKey: "myUsername")
                    isUsernameViewPresented = false
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                }
                .buttonStyle(.borderedProminent)
                .disabled(text.isEmpty)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    NavigationStack {
        PostListView(viewModel: .init())
            .environment(MockJSONAPI())
    }
}
