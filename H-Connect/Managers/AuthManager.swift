//
//  AuthManager.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 17/02/23.
//

import Foundation
import Firebase
import GoogleSignIn

class AuthManager {
    
    static let shared = AuthManager()
    private let auth = Auth.auth()
    
    var userIsLoggedIn: Bool {
        get {
            guard let _ = AuthManager.shared.auth.currentUser else {
                return false
            }
            return true
        }
    }
    
    // MARK: - Email Sign In
    func signInWithEmail(email: String, password: String, completion: @escaping ((VoidResult<Error>) -> Void)) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success)
        }
    }
    
    func signUp(with email: String, password: String, completion: @escaping ((VoidResult<Error>) -> Void)) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success)
        }
    }
    
    func signOut(completion: @escaping ((VoidResult<Error>) -> Void)) {
        do {
            try auth.signOut()
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }
    
    func changePassword(to newPassword: String, completion: @escaping ((VoidResult<Error>) -> Void)) {
        auth.currentUser?.updatePassword(to: newPassword, completion: { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success)
        })
    }
    
    func sendEmailVerification(completion: @escaping ((VoidResult<Error>) -> Void)) {
        auth.currentUser?.sendEmailVerification(completion: { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success)
        })
    }
    
    func listenEmailVerification(completion: @escaping ((VoidResult<Error>) -> Void)) -> AuthStateDidChangeListenerHandle {
        let listener = auth.addStateDidChangeListener { auth, user in
            guard let user = user else {
                completion(.failure(AuthError.signedOut))
                return
            }
            
            if user.isEmailVerified == true {
                completion(.success)
            }
        }
        
        return listener
    }

    // MARK: - 3rd Party Sign In
    func signIn(with credential: AuthCredential, completion: @escaping ((VoidResult<Error>) -> Void)) {
        auth.signIn(with: credential) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success)
        }
    }
    
    // MARK: - Google Sign In
    func signInWithGoogle(presentingViewController: UIViewController, completion: @escaping ((VoidResult<Error>) -> Void)) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(AuthError.missingGoogleId))
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard
                let result = result, let idToken = result.user.idToken else {
                completion(.failure(AuthError.missingGoogleId))
                return
            }
            
            let accessToken = result.user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
        }
    }
    
    // MARK: - Apple Sign In
    func signInWithApple(completion: @escaping ((VoidResult<Error>) -> Void)) {
        
    }
    
    
    // MARK: - Reauthenticate
    func reauthenticate(password: String, completion: @escaping ((VoidResult<Error>) -> Void)) {
        guard let user = auth.currentUser,
              let email = user.email else {
            completion(.failure(AuthError.userNotFound))
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        user.reauthenticate(with: credential) { _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success)
        }
    }
}
