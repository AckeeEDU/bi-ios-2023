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
        if let posts = getPosts() {
            self.posts = posts
            return
        }
        
        var request = URLRequest(url: URL(string: "https://fitstagram.ackee.cz/api/feed")!)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let posts = try! JSONDecoder().decode([Post].self, from: data)
//            print("[Posts]:", posts)
            // Filter our authors without username
            self.posts = posts.filter { !$0.author.username.isEmpty }
            savePosts(self.posts)
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
    
    func getPosts() -> [Post]? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let postsURL = url.appending(component: "posts.json")
        
        guard let data = FileManager.default.contents(atPath: postsURL.path) else { return nil }
        
        return try? JSONDecoder().decode([Post].self, from: data)
    }
    
    func savePosts(_ posts: [Post]) {
//        UserDefaults.custom.posts = posts
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let postsURL = url.appending(component: "posts.json")
        
        guard let postsData = try? JSONEncoder().encode(posts) else { return }
        
        do {
            try postsData.write(to: postsURL)
        } catch {
            print(error)
        }
    }
    
    func fetchPost(postID: Post.ID) {
        Task { @MainActor in
            do {
                let updatedPost = try await performPostUpdate(postID: postID)
                guard let index = posts.firstIndex(where: { $0.id == updatedPost.id }) else {
                    // Custom error
                    throw MyError()
                }
                
                posts[index] = updatedPost
            } catch {
                print("[ERROR] Post fetch error ", error)
            }
        }
    }
    
    // MARK: - Private helpers
    
    private func performPostUpdate(postID: Post.ID) async throws -> Post {
        var request = URLRequest(url: URL(string: "https://fitstagram.ackee.cz/api/feed/" + postID)!)
        request.httpMethod = "GET"
        print("⬆️ [Post]:", request)
        let (data, _) = try await URLSession.shared.data(for: request)
        let post = try! JSONDecoder().decode(Post.self, from: data)
        print("⬇️ [Post]:", post)
        return post
    }
}

struct MyError: Error {
    
}

extension UserDefaults {
    private static let postsKey = "posts"
    
    var posts: [Post] {
        get {
            let postsString = string(forKey: Self.postsKey)
            
            guard let postsData = postsString?.data(using: .utf8) else {
                return []
            }
            
            return (try? JSONDecoder().decode([Post].self, from: postsData)) ?? []
        }
        set { 
            guard let data = try? JSONEncoder().encode(newValue) else {
                return
            }
            
            set(String(data: data, encoding: .utf8), forKey: Self.postsKey)
        }
    }
}
