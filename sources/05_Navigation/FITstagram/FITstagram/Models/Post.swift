//
//  Post.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 11.10.2023.
//

import Foundation

@propertyWrapper struct PhotoNamespace: Equatable {
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

struct Post: Identifiable, Equatable {
    let id = UUID()
    let author: User
    let text: String
    @PhotoNamespace("Posts")
    var photo: String = ""
    let likes: [User]
    let numberOfComments: Int
    
    // Computed property
    var numberOfLikes: Int {
        likes.count
    }
}

extension Post {
    static let postMock = Post(
        author: .userMock1,
        text: "Toto je muj velmi dlouhy komentar a bude na dva razky",
        photo: "sonoma",
        likes: User.usersMock.filter { $0.username != User.userMock1.username },
        numberOfComments: 27
    )
    
    static let postsMock: [Post] = [
        .init(
            author: .userMock1,
            text: "I tentokrát platí nejdřív kvásek, potom legrace. Pěkně vzešlý polštářek kvasinkového bujení zaručí nadýchaný výsledek. Potřebujete tak lžíci nebo dvě hladké mouky, minimálně dvě lžíce moučkového cukru, rozdrolenou čtvrtinu kostky čerstvého droždí a pár lžic vlažného mléka. Suché složky míchejte až do kašoidní konzistence.",
            photo: "1",
            likes: User.usersMock.filter { $0.username != User.userMock1.username },
            numberOfComments: 27
        ),
        Post(
            author: .userMock2,
            text: "Regiony jako Napa a Sonoma mohou být teplejší díky okolním pohořím, které vinice ochraňují před přímým vlivem oceánu.",
            photo: "2",
            likes: User.usersMock.filter { $0.username != User.userMock2.username },
            numberOfComments: 2
        ),
        Post(
            author: .userMock3,
            text: "Example comment.",
            photo: "3",
            likes: User.usersMock.filter { $0.username != User.userMock3.username },
            numberOfComments: 2
        ),
        Post(
            author: .userMock4,
            text: "Another example comment.",
            photo: "4",
            likes: User.usersMock.filter { $0.username != User.userMock4.username },
            numberOfComments: 2
        ),
        Post(
            author: .userMock5,
            text: "Another example comment.",
            photo: "5",
            likes: User.usersMock.filter { $0.username != User.userMock5.username },
            numberOfComments: 2
        )
    ]
}
