//
//  Post.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 11.10.2023.
//

import Foundation

struct Post {
    let username: String
    let image: String
    let description: String
    let likesCount: Int
    let comments: [String]

    // Computed property
    var commentsCount: Int {
        comments.count
    }
}

extension Post {
    static let mock = Post(
        username: "rostislav.babacek",
        image: "sonoma",
        description: "Toto je muj velmi dlouhy komentar a bude na dva razky",
        likesCount: 990,
        comments: ["Cool!"]
    )
}
