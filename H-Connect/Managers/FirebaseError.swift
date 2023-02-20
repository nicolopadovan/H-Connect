//
//  FirebaseError.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 17/02/23.
//

import Foundation

enum FirestoreError: Error {
    case documentNotFound
    case collectionIsEmpty
    case documentDoesNotExist
    case decodeError
}

enum AuthError: Error {
    case signedOut
    case userNotFound
    case missingGoogleId
}
