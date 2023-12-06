import Foundation

protocol JSONAPIServicing: Observable {
    func fetchPostDetail(postID: Post.ID) async throws -> Post
}

@Observable
final class JSONAPIService: JSONAPIServicing {
    func fetchPostDetail(postID: Post.ID) async throws -> Post {
        let request = URLRequest(url: .post(id: postID))
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Post.self, from: data)
    }
}
