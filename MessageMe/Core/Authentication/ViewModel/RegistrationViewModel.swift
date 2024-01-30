//
//  RegistrationViewModel.swift
//  MessageMe
//
//  Created by Thomas Garayua on 1/30/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: email, password: password, fullname: fullname)
    }
}
