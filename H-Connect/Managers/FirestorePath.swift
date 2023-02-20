//
//  FirebasePath.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 17/02/23.
//

import Foundation

protocol PathComponent {
    var rawValue: String { get }
}

struct FirestorePath {
    private let pathComponents: [PathComponent]

    public
    enum Collection: String, PathComponent {
        case users = "users"
    }
    
    public
    enum Document: String, PathComponent {
        case user = "user"
    }
    
    public
    enum Field: String, PathComponent {
        case name = "name"
        case email = "email"
        case profileImageURL = "pfpUrl"
        case uid = "uid"
    }

    init(pathComponents: [PathComponent]) {
        self.pathComponents = pathComponents
    }

    var fullPath: String {
        let componentStrings = pathComponents.map { $0.rawValue }
        return componentStrings.joined(separator: "/")
    }

    func appending(_ pathComponent: PathComponent) -> FirestorePath {
        var pathComponents = self.pathComponents
        pathComponents.append(pathComponent)
        return FirestorePath(pathComponents: pathComponents)
    }
}
