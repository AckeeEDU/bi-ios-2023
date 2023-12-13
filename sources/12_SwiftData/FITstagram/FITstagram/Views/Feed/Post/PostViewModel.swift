//
//  PostViewModel.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 21.11.2023.
//

import Foundation
import Observation

@Observable final class PostViewModel {
    var post: Post
    private var onCommentsTapped: () -> Void
    private var onPostUpdated: () -> Void
    private(set) var isBookmarked = false
    var isLiked: Bool {
        post.likes.contains(where: { $0.username == myUsername })
    }
    
    // MARK: - Initialization
    
    init(
        post: Post,
        onCommentsTapped: @escaping () -> Void,
        onPostUpdated: @escaping () -> Void
    ) {
        self.post = post
        self.onCommentsTapped = onCommentsTapped
        self.onPostUpdated = onPostUpdated
    }
    
    // MARK: - Public helpers
    
    func toggleBookmark() {
        isBookmarked.toggle()
    }
    
    func showComments() {
        onCommentsTapped()
    }
    
    func likePost() {
        // We forgot @MainActor inside the task, so the faked likes didn't work as expected. Don't forget it!! 🫣
        Task { @MainActor in
            let originalPost = post
            do {
                post = Post(
                    id: post.id,
                    author: post.author,
                    text: post.text,
                    likes: post.likes + [
                        User(
                            username: myUsername,
                            firstName: nil,
                            lastName: nil
                        )
                    ],
                    comments: post.comments,
                    photos: post.photos
                )
                try await performLikePost()
                // API bug workaround
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    self?.onPostUpdated()
                }
            } catch {
                post = originalPost
                print("[ERROR] Like post error ", error)
            }
        }
    }
    
    // MARK: - Private helpers
    
    private func performLikePost() async throws {
        var request = URLRequest(url: URL(string: "https://fitstagram.ackee.cz/api/feed/" + post.id + "/like")!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Authorization": myUsername
        ]
        print("⬆️ likePost: ", request)
        let (_, response) = try await URLSession.shared.data(for: request)
        print("⬇️ likePost: ", ((response as? HTTPURLResponse)?.statusCode ?? ""))
    }
}
