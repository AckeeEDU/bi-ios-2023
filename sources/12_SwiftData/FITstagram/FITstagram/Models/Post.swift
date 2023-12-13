//
//  Post.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 11.10.2023.
//

import Foundation
import SwiftData

@propertyWrapper struct PhotoNamespace: Equatable, Hashable {
    private let namespace: String
    private let value: String
    
    var wrappedValue: String {
        // Wrapped value contains original value prefixed by namespace
        namespace + "/" + value
    }
    
    init(wrappedValue: String, _ namespace: String) {
        self.namespace = namespace
        self.value = wrappedValue
    }
    
    var projectedValue: String {
        // Projected value allows us to access original value
        value
    }
}

// MARK: - Post struct

@Model
final class PostMO {
    @Attribute(.unique) var id: String
    let author: User
    let text: String
    let likes: [User]
    let comments: Int
    let photos: [URL]
    
    var post: Post {
        .init(
            id: id,
            author: author,
            text: text,
            likes: likes,
            comments: comments,
            photos: photos
        )
    }
    
    init(
        id: String,
        author: User,
        text: String,
        likes: [User],
        comments: Int,
        photos: [URL]
    ) {
        self.id = id
        self.author = author
        self.text = text
        self.likes = likes
        self.comments = comments
        self.photos = photos
    }
    
    init(post: Post) {
        self.id = post.id
        self.author = post.author
        self.text = post.text
        self.likes = post.likes
        self.comments = post.comments
        self.photos = post.photos
    }
}

struct Post: Identifiable, Equatable, Hashable, Decodable, Encodable {
    
    // MARK: - Internal properties
    
    let id: String
    let author: User
    let text: String
    let likes: [User]
    var likesCount: Int {
        likes.count
    }
    let comments: Int
    let photos: [URL]
    
    init(
        id: String,
        author: User,
        text: String,
        likes: [User],
        comments: Int,
        photos: [URL]
    ) {
        self.id = id
        self.author = author
        self.text = text
        self.likes = likes
        self.comments = comments
        self.photos = photos
    }
    
    // MARK: - Coding keys
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case text
        case likes
        case comments = "numberOfComments"
        case photos
    }
}

// MARK: - Extensions

extension Post {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.author = try container.decode(User.self, forKey: .author)
        self.text = try container.decode(String.self, forKey: .text)
        self.likes = try container.decode([User].self, forKey: .likes)
//        let likes = try container.decode([String].self, forKey: .likes)
//        self.likes = likes.count
        self.comments = try container.decode(Int.self, forKey: .comments)
        self.photos = try container.decode([URL].self, forKey: .photos)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(author, forKey: .author)
        try container.encode(text, forKey: .text)
        try container.encode(likes, forKey: .likes)
        try container.encode(comments, forKey: .comments)
        try container.encode(photos, forKey: .photos)
    }
}

extension KeyedDecodingContainer {
    func decode<T: Decodable>(forKey key: Key) throws -> T  {
        try decode(T.self, forKey: key)
    }
}

extension Post {
    static let postMock = Post(
        id: UUID().uuidString,
        author: .userMock1,
        text: "Toto je muj velmi dlouhy komentar a bude na dva razky",
        likes: User.usersMock,
        comments: 27,
        photos: []
    )
    
    static let postsMock: [Post] = [
        .init(
            id: UUID().uuidString,
            author: .userMock1,
            text: "I tentokrát platí nejdřív kvásek, potom legrace. Pěkně vzešlý polštářek kvasinkového bujení zaručí nadýchaný výsledek. Potřebujete tak lžíci nebo dvě hladké mouky, minimálně dvě lžíce moučkového cukru, rozdrolenou čtvrtinu kostky čerstvého droždí a pár lžic vlažného mléka. Suché složky míchejte až do kašoidní konzistence.",
            likes: User.usersMock,
            comments: 27,
            photos: []
        ),
        Post(
            id: UUID().uuidString,
            author: .userMock2,
            text: "Regiony jako Napa a Sonoma mohou být teplejší díky okolním pohořím, které vinice ochraňují před přímým vlivem oceánu.",
            likes: User.usersMock,
            comments: 2,
            photos: []
        ),
        Post(
            id: UUID().uuidString,
            author: .userMock3,
            text: "Example comment.",
            likes: User.usersMock,
            comments: 2,
            photos: []
        ),
        Post(
            id: UUID().uuidString,
            author: .userMock4,
            text: "Another example comment.",
            likes: User.usersMock,
            comments: 2,
            photos: []
        ),
        Post(
            id: UUID().uuidString,
            author: .userMock5,
            text: "Another example comment.",
            likes: User.usersMock,
            comments: 2,
            photos: []
        )
    ]
}
