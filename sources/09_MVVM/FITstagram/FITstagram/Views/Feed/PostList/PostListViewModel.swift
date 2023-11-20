//
//  PostsListViewModel.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 14.11.2023.


import Foundation

/// PostListVM uses iOS13+ changes observation system
final class PostListViewModel: ObservableObject {
    // MARK: - Public properties
    ///    var posts: [Post] = [] {
    ///        willSet {
    ///            objectWillChange.send()
    ///        }
    ///    }
    @Published private(set) var posts: [Post] = []
    @Published var presentedCommentsPost: Post?
    @Published var isUsernameViewPresented = false
    
    // MARK: - Public helpers
    
    @MainActor
    func fetchPosts() async {
        var request = URLRequest(url: URL(string: "https://fitstagram.ackee.cz/api/feed")!)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let posts = try! JSONDecoder().decode([Post].self, from: data)
            print("[Posts]:", posts)
            // Filter our authors without username
            self.posts = posts.filter { !$0.author.username.isEmpty }
        } catch {
            print("[ERROR] Posts fetch error ", error)
        }
    }
    
    func showCommentsList(_ post: Post) {
        presentedCommentsPost = post
    }
    
    func hideCommentsList() {
        presentedCommentsPost = nil
    }
    
    func showGallery() {
        // TODO: Load images from gallery
    }
    
    func openCamera() {
        // TODO: Take a photo
    }

    func showUsernameView() {
        isUsernameViewPresented = true
    }
}
