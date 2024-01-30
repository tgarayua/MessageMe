//
//  User.swift
//  MessageMe
//
//  Created by Thomas Garayua on 1/30/24.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    var id = NSUUID().uuidString
    let fullname: String
    let email: String
    var profileImageUrl: String?
}

extension User {
    static let MOCK_USER = User(fullname: "Spider Man", email: "Spiderman@gmail.com", profileImageUrl: "Spider-man")
}
