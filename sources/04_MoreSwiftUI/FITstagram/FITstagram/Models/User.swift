//
//  User.swift
//  FITstagram
//
//  Created by Rostislav Babáček on 13.10.2023.
//

import Foundation

struct User {
    let username: String
    let firstName: String?
    let lastName: String?
}

extension User {
    static let userMock1 = User(username: "jan_novak", firstName: "Jan", lastName: "Novák")
    static let userMock2 = User(username: "jana_smetana", firstName: "Jana", lastName: "Smetana")
    static let userMock3 = User(username: "alice_kovářová", firstName: "Alice", lastName: "Kovářová")
    static let userMock4 = User(username: "martin_král", firstName: "Martin", lastName: "Král")
    static let userMock5 = User(username: "petra_němcová", firstName: "Petra", lastName: "Němcová")
    static let userMock6 = User(username: "tomáš_veselý", firstName: "Tomáš", lastName: "Veselý")
    static let userMockMe = User(username: "rostislav.babacek", firstName: "Rostislav", lastName: "Babáček")

    static let usersMock: [User] = [
        userMock2,
        userMock3,
        userMock4,
        userMock5,
        userMock6
    ]
}
