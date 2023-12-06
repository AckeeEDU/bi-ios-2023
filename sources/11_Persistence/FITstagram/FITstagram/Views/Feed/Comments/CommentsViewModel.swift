//
//  CommentsViewModel.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 14.11.2023.
//

import Foundation
import Observation

// TODO: Lecture 09 - finish implementation
/// CommentsVM uses iOS17+ changes observation system
@Observable final class CommentsViewModel {
    // MARK: - Private properties
    private let postID: Post.ID
    
    // MARK: - Public properties
    var comments: [Comment] = []
    var text = ""
    var isAlertPresented = false
    var commentToBeDeleted: Comment?
    var onCommentsClose: (Bool) -> Void
    var isLoading = true
    var commentsChanged = false
    
    var isEmptyTextVisible: Bool {
        !isLoading && comments.isEmpty
    }
    
    // MARK: - Initialization
    
    init(
        postID: Post.ID,
        onCommentsClose: @escaping (Bool) -> Void
    ) {
        self.postID = postID
        self.onCommentsClose = onCommentsClose
    }
    
    // MARK: - Public helpers
    
    @MainActor
    func fetchComments() async {
        defer { isLoading = false }
        isLoading = true
        
        do {
            comments = try await performFetchComments()
        } catch {
            print("[ERROR] Comments fetch error ", error)
        }
    }
    
    @MainActor
    func closeCommentsView() {
        onCommentsClose(commentsChanged)
    }
    
    func addComment() {
        Task { @MainActor in
            do {
                try await performAddComment(postID: postID, text: text)
                text = ""
                comments = try await performFetchComments()
                commentsChanged = true
            } catch {
                
            }
        }
    }
    
    func removeComment(comment: Comment) {
        commentToBeDeleted = comment
        isAlertPresented = true
    }
    
    // MARK: - Private helpers
    
    private func performAddComment(
        postID: Post.ID,
        text: String
    ) async throws {
        struct AddCommentBody: Encodable {
            let text: String
        }
        
        var request = URLRequest(
            url: URL(string: "https://fitstagram.ackee.cz/api/feed/" + postID + "/comments")!
        )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Authorization": myUsername
        ]
        let body = AddCommentBody(text: text)
        request.httpBody = try JSONEncoder().encode(body)
        
        print("⬆️ addComment: ", request)
        let (_, response) = try await URLSession.shared.data(for: request)
        print("⬇️ addComment: ", ((response as? HTTPURLResponse)?.statusCode ?? ""))
    }
    
    private func performFetchComments() async throws -> [Comment] {
        var request = URLRequest(
            url: URL(string: "https://fitstagram.ackee.cz/api/feed/" + postID + "/comments")!
        )
        request.httpMethod = "GET"
        
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let comments = try! JSONDecoder().decode([Comment].self, from: data)
        print("[Comments]:", comments)
        return comments
    }
}
