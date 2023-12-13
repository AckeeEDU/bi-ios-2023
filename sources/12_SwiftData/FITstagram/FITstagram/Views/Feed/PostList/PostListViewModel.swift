//
//  PostsListViewModel.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 14.11.2023.


import Foundation
import SwiftData
import SwiftUI

@Observable
final class PostListViewModel {
    // MARK: - Public properties
    var presentedCommentsPost: Post?
    var isUsernameViewPresented = false
    
    private let jsonAPI: JSONAPIServicing
    private let modelContainer: ModelContainer
    
    // MARK: - Initializers
    
    init(jsonAPI: JSONAPIServicing, modelContainer: ModelContainer) {
        self.jsonAPI = jsonAPI
        self.modelContainer = modelContainer
    }
    
    // MARK: - Public helpers
    
    @MainActor
    func fetchPosts() async {
        do {
            let posts = try await jsonAPI.fetchFeed()
            let filteredPosts = posts.filter { $0.author.username.isEmpty }
            savePosts(filteredPosts)
        } catch {
            print("[ERROR]", error)
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
    
    func savePosts(_ posts: [Post]) {
        let posts = posts.map(PostMO.init)
//        let posts = posts.map { PostMO(post: $0) }
        let context = ModelContext(modelContainer)
        
        posts.forEach { post in
            context.insert(post)
        }
    }
    
    func fetchPost(postID: Post.ID) {
//        Task { @MainActor in
//            do {
//                let updatedPost = try await performPostUpdate(postID: postID)
//                guard let index = posts.firstIndex(where: { $0.id == updatedPost.id }) else {
//                    // Custom error
//                    throw MyError()
//                }
//                
//                posts[index] = updatedPost
//            } catch {
//                print("[ERROR] Post fetch error ", error)
//            }
//        }
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
