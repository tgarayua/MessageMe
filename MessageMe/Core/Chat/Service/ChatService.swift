//
//  ChatService.swift
//  MessageMe
//
//  Created by Thomas Garayua on 2/4/24.
//

import Foundation
import Firebase

struct ChatService {
    
    let chatPartner: User
    
    func sendMessage(_ messageText: String) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let currentUserRef = FirestoreConstants.MessagesCollection.document(currentUid).collection(chatPartnerId).document()
        let chatPartnerRef = FirestoreConstants.MessagesCollection.document(chatPartnerId).collection(currentUid)
        
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
    
    func observeMessages(completion: @escaping([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let query = FirestoreConstants.MessagesCollection
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self ) })
            
            for (index, message) in messages.enumerated() where !message.isFromCurrentUser {
                messages[index].user = chatPartner
            }
            
            completion(messages)
        }
    }
}
