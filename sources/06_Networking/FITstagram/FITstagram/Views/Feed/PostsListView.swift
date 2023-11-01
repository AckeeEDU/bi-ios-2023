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
            .onAppear {
                fetchPosts()
            }
        }
    }
    
    // MARK: - UI Components
    
    var postListContentView: some View {
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
    
    // MARK: - Private helpers
    
    private func fetchPosts() {
        var request = URLRequest(url: URL(string: "https://fitstagram.ackee.cz/api/feed")!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print("[ERROR]: ", error)
            }
            
            if let response {
                print("[RESPONSE]: ", response)
            }
            
            if let data {
                let dataString = String(data: data, encoding: .utf8)!
                print(dataString)
            }
        }
        
        task.resume()
    }
}

#Preview {
    NavigationStack {
        PostsListView()
    }
}
