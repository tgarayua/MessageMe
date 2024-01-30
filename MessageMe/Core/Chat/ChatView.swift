//
//  ChatView.swift
//  MessageMe
//
//  Created by Thomas Garayua on 1/30/24.
//

import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    var body: some View {
        VStack {
            ScrollView {
                // header
                VStack {
                    CircularProfileImageView(user: User.MOCK_USER, size: .xLarge)
                    
                    VStack(spacing: 4) {
                        Text("Spider Man")
                            .font(.title3)
                        
                        Text("Messager")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                
                // messages
                
                ForEach(0 ... 25, id:\.self) { message in
                    ChatMessageCell(isFromCurrentUser: Bool.random())
                }
                
            }
            // message input view
            
            Spacer()
            
            ZStack(alignment: .trailing) {
                TextField("Message...", text: $messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button {
                    print("Send message")
                } label: {
                    Text("Send")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
