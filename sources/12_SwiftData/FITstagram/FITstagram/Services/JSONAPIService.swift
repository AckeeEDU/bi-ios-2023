import Foundation

protocol JSONAPIServicing: Observable {
    func fetchPostDetail(postID: Post.ID) async throws -> Post
    func fetchFeed() async throws -> [Post]
}

@Observable
final class JSONAPIService: JSONAPIServicing {
    func fetchPostDetail(postID: Post.ID) async throws -> Post {
        let request = URLRequest(url: .post(id: postID))
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Post.self, from: data)
    }
    
    func fetchFeed() async throws -> [Post] {
        var request = URLRequest(url: .feed)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([Post].self, from: data)
    }
}
