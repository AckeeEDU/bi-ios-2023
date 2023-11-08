//
//  Post.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 11.10.2023.
//

import Foundation

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

struct Post: Identifiable, Equatable, Hashable, Decodable {
    
    // MARK: - Internal properties
    
    let id: String
    let author: User
    let text: String
    let likes: Int
    let comments: Int
    let photos: [URL]
    
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
        let likes = try container.decode([String].self, forKey: .likes)
        self.likes = likes.count
        self.comments = try container.decode(Int.self, forKey: .comments)
        self.photos = try container.decode([URL].self, forKey: .photos)
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
        likes: 100,
        comments: 27, 
        photos: []
    )
    
    static let postsMock: [Post] = [
        .init(
            id: UUID().uuidString,
            author: .userMock1,
            text: "I tentokrát platí nejdřív kvásek, potom legrace. Pěkně vzešlý polštářek kvasinkového bujení zaručí nadýchaný výsledek. Potřebujete tak lžíci nebo dvě hladké mouky, minimálně dvě lžíce moučkového cukru, rozdrolenou čtvrtinu kostky čerstvého droždí a pár lžic vlažného mléka. Suché složky míchejte až do kašoidní konzistence.",
            likes: 1,
            comments: 27,
            photos: []
        ),
        Post(
            id: UUID().uuidString,
            author: .userMock2,
            text: "Regiony jako Napa a Sonoma mohou být teplejší díky okolním pohořím, které vinice ochraňují před přímým vlivem oceánu.",
            likes: 2,
            comments: 2,
            photos: []
        ),
        Post(
            id: UUID().uuidString,
            author: .userMock3,
            text: "Example comment.",
            likes: 3,
            comments: 2,
            photos: []
        ),
        Post(
            id: UUID().uuidString,
            author: .userMock4,
            text: "Another example comment.",
            likes: 4,
            comments: 2,
            photos: []
        ),
        Post(
            id: UUID().uuidString,
            author: .userMock5,
            text: "Another example comment.",
            likes: 5,
            comments: 2,
            photos: []
        )
    ]
}
