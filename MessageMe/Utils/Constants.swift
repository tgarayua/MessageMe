//
//  Constants.swift
//  MessageMe
//
//  Created by Thomas Garayua on 2/4/24.
//

import Foundation
import Firebase

struct FirestoreConstants {
    static let UserCollection = Firestore.firestore().collection("user")
    static let MessagesCollection = Firestore.firestore().collection("messages")
}
