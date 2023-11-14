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
    var onCommentsClose: () -> Void
    var isLoading = true
    
    var isEmptyTextVisible: Bool {
        !isLoading && comments.isEmpty
    }
    
    // MARK: - Initialization
    
    init(
        postID: Post.ID,
        onCommentsClose: @escaping () -> Void
    ) {
        self.postID = postID
        self.onCommentsClose = onCommentsClose
    }
    
    // MARK: - Public helpers
    
    @MainActor
    func fetchComments() async {
        defer { isLoading = false }
        isLoading = true
        var request = URLRequest(
            url: URL(string: "https://fitstagram.ackee.cz/api/feed/" + postID + "/comments")!
        )
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let comments = try! JSONDecoder().decode([Comment].self, from: data)
            print("[Comments]:", comments)
            self.comments = comments
        } catch {
            print("[ERROR] Posts fetch error.")
        }
    }
    
    func closeCommentsView() {
        self.onCommentsClose()
    }
}
