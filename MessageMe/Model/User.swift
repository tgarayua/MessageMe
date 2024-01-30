//
//  User.swift
//  MessageMe
//
//  Created by Thomas Garayua on 1/30/24.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
    @DocumentID var uid: String?
    let fullname: String
    let email: String
    var profileImageUrl: String?
    
    var id: String {
        return uid ?? NSUUID().uuidString
    }
}

extension User {
    static let MOCK_USER = User(fullname: "Spider Man", email: "Spiderman@gmail.com", profileImageUrl: "Spider-man")
}
