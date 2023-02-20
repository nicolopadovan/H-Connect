//
//  FirestoreManager.swift
//  H-Connect
//
//  Created by Nicolò Padovan on 17/02/23.
//

import Foundation
import Firebase

final
class FirestoreManager {
    
    static let shared = FirestoreManager()
    private let db = Firestore.firestore()
    
    // MARK: - Read Operations
    func downloadDocuments<T: Codable>(collectionPath: FirestorePath, with type: T.Type, completion: ((Result<[T], Error>) -> Void)?) {
        db.collection(collectionPath.fullPath).getDocuments { snapshot, error in
            if let error = error {
                completion?(.failure(error))
                return
            }
            
            guard let snapshot = snapshot else {
                completion?(.failure(FirestoreError.collectionIsEmpty))
                return
            }
            
            if snapshot.documents.isEmpty {
                completion?(.failure(FirestoreError.collectionIsEmpty))
                return
            }
            
            // Convert the documents to the T type
            let data = snapshot.documents.compactMap({ $0.data().toObject(type: type) })
            completion?(.success(data))
        }
    }
    
    func downloadDocument<T: Codable>(documentPath: FirestorePath, with type: T.Type, completion: ((Result<T, Error>) -> Void)?) {
        db.document(documentPath.fullPath).getDocument { snapshot, error in
            if let error = error {
                completion?(.failure(error))
                return
            }
            
            guard let snapshot = snapshot else {
                completion?(.failure(FirestoreError.documentDoesNotExist))
                return
            }
            
            let data = snapshot.data()?.toObject(type: type)
            guard let data = data else {
                completion?(.failure(FirestoreError.decodeError))
                return
            }
            
            completion?(.success(data))
        }
    }
    
    // MARK: - Observers
    private var listeners: [String: ListenerRegistration] = [:]
    func attachListener<T: Codable>(to document: FirestorePath, type: T.Type, completion: @escaping ((Result<T, Error>) -> Void)) {
        let listener = db.document(document.fullPath).addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard
                let snapshot = snapshot,
                let data = snapshot.data(),
                let object = data.toObject(type: type) else {
                completion(.failure(FirestoreError.decodeError))
                return
            }
            
            completion(.success(object))
        }
        
        listeners[document.fullPath] = listener
    }
    
    func detatchListener(from document: FirestorePath, completion: ((VoidResult<Error>) -> Void)?) {
        listeners[document.fullPath]?.remove()
        listeners.removeValue(forKey: document.fullPath)
    }
    
    func detatchAllListeners(comletion: ((VoidResult<Error>) -> Void)?) {
        listeners.values.forEach({ $0.remove() })
        listeners = [:]
    }
    
    struct BatchOperation<T: Codable> {
        let operationType: OperationType
        let data: T
        
        enum OperationType {
            case uploadDocumentWithAutoID(collectionPath: FirestorePath)
            case uploadDocument(documentPath: FirestorePath)
            case updateDocument(documentPath: FirestorePath)
            case uploadOrUpdateDocument(documentPath: FirestorePath)
            case overwriteDocument(documentPath: FirestorePath)
            case deleteDocument(documentPath: FirestorePath)
        }
    }
    
    func batchedWrite<T: Codable>(operations: [BatchOperation<T>], completion: ((VoidResult<Error>) -> Void)?) {
        let batch = db.batch()
        
        for operation in operations {
            switch operation.operationType {
            case .uploadDocumentWithAutoID(collectionPath: let collectionPath):
                self.uploadDocumentWithAutoID(collectionPath: collectionPath, data: operation.data, completion: nil)
            case .uploadDocument(documentPath: let documentPath):
                self.uploadDocument(documentPath: documentPath, data: operation.data, completion: nil)
            case .updateDocument(documentPath: let documentPath):
                self.updateDocument(documentPath: documentPath, data: operation.data, completion: nil)
            case .uploadOrUpdateDocument(documentPath: let documentPath):
                self.uploadOrUpdateDocument(documentPath: documentPath, data: operation.data, completion: nil)
            case .overwriteDocument(documentPath: let documentPath):
                self.overwriteDocument(documentPath: documentPath, data: operation.data, completion: nil)
            case .deleteDocument(documentPath: let documentPath):
                self.deleteDocument(documentPath: documentPath, completion: nil)
            }
        }
        
        batch.commit { error in
            if let error = error {
                completion?(.failure(error))
            } else {
                completion?(.success)
            }
        }
    }
    
    func uploadDocumentWithAutoID<T: Codable>(collectionPath: FirestorePath, data: T, completion: ((VoidResult<Error>) -> Void)?) {
        db.collection(collectionPath.fullPath).addDocument(data: data.dict()) { error in
            if let error = error {
                completion?(.failure(error))
                return
            }
            
            completion?(.success)
        }
    }
    
    func uploadDocument<T: Codable>(documentPath: FirestorePath, data: T, completion: ((VoidResult<Error>) -> Void)?) {
        db.document(documentPath.fullPath).setData(data.dict(), merge: false) { error in
            if let error = error {
                completion?(.failure(error))
                return
            }
            
            completion?(.success)
        }
    }
    
    func updateDocument<T: Codable>(documentPath: FirestorePath, data: T, completion: ((VoidResult<Error>) -> Void)?) {
        db.document(documentPath.fullPath).updateData(data.dict()) { error in
            if let error = error {
                completion?(.failure(error))
                return
            }
            
            completion?(.success)
        }
    }
    
    func uploadOrUpdateDocument<T: Codable>(documentPath: FirestorePath, data: T, completion: ((VoidResult<Error>) -> Void)?) {
        db.document(documentPath.fullPath).setData(data.dict(), merge: true) { error in
            if let error = error {
                completion?(.failure(error))
                return
            }
            
            completion?(.success)
        }
    }
    
    func overwriteDocument<T: Codable>(documentPath: FirestorePath, data: T, completion: ((VoidResult<Error>) -> Void)?) {
        db.document(documentPath.fullPath).setData(data.dict(), merge: false) { error in
            if let error = error {
                completion?(.failure(error))
                return
            }
            
            completion?(.success)
        }
    }
    
    func deleteDocument(documentPath: FirestorePath, completion: ((VoidResult<Error>) -> Void)?) {
        db.document(documentPath.fullPath).delete() { error in
            if let error = error {
                completion?(.failure(error))
                return
            }
            
            completion?(.success)
        }
    }
    
    
}
