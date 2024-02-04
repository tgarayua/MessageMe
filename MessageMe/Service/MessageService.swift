//
//  MessageService.swift
//  MessageMe
//
//  Created by Thomas Garayua on 2/4/24.
//

import Foundation
import Firebase

struct MessageService {
    
    static let messagesCollection = Firestore.firestore().collection("messages")
    
    static func sendMessage(_ messageText: String, toUser user: User) {
        guard let currentUid = Auth.auth().currentUser?.uid else {
            print("DEBUG: User is not authenticated.")
            return
            
        }
        let chatPartnerId = user.id
        
        let currentUserRef = messagesCollection.document(currentUid).collection(chatPartnerId).document()
        let chatPartnerRef = messagesCollection.document(chatPartnerId).collection(currentUid)
        
        let messageId = currentUserRef.documentID
        
        let message = Message(messageId: messageId,
                              fromId: currentUid,
                              toId: chatPartnerId,
                              messageText:
                                messageText,
                              timestamp: Timestamp()
        )
        
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        
//        print("DEBUG: messageData \(messageData)")
        
        currentUserRef.setData(messageData) { error in
            if let error = error {
                print("Error writing currentUserRef: \(error.localizedDescription)")
            } else {
                print("DEBUG: Message added to currentUserRef successfully.")
            }
        }
        chatPartnerRef.document(messageId).setData(messageData) { error in
            if let error = error {
                print("Error writing chatPartnerRef: \(error.localizedDescription)")
            } else {
                print("DEBUG: Message added to chatPartnerRef successfully.")
            }
        }
    }
}
