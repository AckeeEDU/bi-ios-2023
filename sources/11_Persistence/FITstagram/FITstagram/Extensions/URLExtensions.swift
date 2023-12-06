import Foundation

extension URL {
    static let feed = URL(string: "https://fitstagram.ackee.cz/api/feed")!
    
    static func post(id: Post.ID) -> URL {
        .init(string: "https://fitstagram.ackee.cz/api/feed/" + id)!
    }
    
    static func comments(postID: Post.ID) -> URL {
        .init(string: "https://fitstagram.ackee.cz/api/feed/" + postID + "/comments")!
    }
}
