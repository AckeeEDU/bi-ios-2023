//
//  PostsListView.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 17.10.2023.
//

import SwiftUI

struct PostsListView: View {
    @State var posts: [Post] = []
    @State private var isCommentsViewPresented = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ScrollView {
                postListContentView
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
                isPresented: $isCommentsViewPresented
            ) {
                CommentsView(
                    isCommentsViewPresented: $isCommentsViewPresented
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
                        // Load images from gallery
                    } label: {
                        Image(systemName: "photo.stack.fill")
                    }
                    .tint(.pink)
                    
                    Button {
                        // Take a photo
                    } label: {
                        Image(systemName: "camera")
                    }
                    .tint(.pink)
                }
            }
            .onChange(of: isCommentsViewPresented) { oldValue, newValue in
                // You can see that dismissing view via drag gesture changes the state. This is possible thanks to binding that is passed to sheet.
                // print("[Old Value]:", oldValue, " [New Value]:", newValue)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Feed")
            .task {
                await fetchPosts()
            }
        }
    }
    
    // MARK: - UI Components
    
    var postListContentView: some View {
        LazyVStack(spacing: 24) {
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
    
    // MARK: - Private helpers
    
    private func fetchPosts() async {
        var request = URLRequest(url: URL(string: "https://fitstagram.ackee.cz/api/feed")!)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let posts = try! JSONDecoder().decode([Post].self, from: data)
            
            self.posts = posts
        }
        catch {
            print("[ERROR] Posts fetch error.")
        }
    }
}

#Preview {
    NavigationStack {
        PostsListView(posts: Post.postsMock)
    }
}
