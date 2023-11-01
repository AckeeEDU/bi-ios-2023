//
//  Comment.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 13.10.2023.
//

import Foundation

struct Comment: Identifiable, Equatable {
    let id: UUID = .init()
    let author: User
    let likes: [User]
    let text: String
}

extension Comment {
    static let commentMock1 = Comment(
        author: User.userMock3,
        likes: [
            User.userMock1,
            User.userMock2,
            User.userMock4
        ],
        text: "Another example comment."
    )

    static let commentMock2 = Comment(
        author: User.userMock1,
        likes: [
            User.userMock3,
            User.userMock4
        ],
        text: "Swift combines powerful type inference and pattern matching with a modern, lightweight syntax, allowing complex ideas to be expressed in a clear and concise manner. As a result, code is not just easier to write, but easier to read and maintain as well."
    )
    
    static let commentMock3 = Comment(
        author: User.userMock5,
        likes: [
            User.userMock3,
            User.userMock4
        ],
        text: "A third comment for demonstration."
    )
    
    static let commentsMock: [Comment] = [
        commentMock1,
        commentMock2,
        commentMock3
    ]
}
