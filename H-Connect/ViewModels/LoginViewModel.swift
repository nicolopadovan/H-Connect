//
//  LoginViewModel.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 18/02/23.
//

import UIKit

class LoginViewModel: ViewModel<LoginCoordinator> {
    
    func login(email: String, password: String, completion: @escaping (VoidResult<Error>) -> Void) {
        AuthManager.shared.signInWithEmail(email: email, password: password) { result in
            switch result {
            case .success:
                print(self.coordinator)
                self.coordinator.navigate()
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
