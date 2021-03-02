//
//  AuthManager.swift
//  IIIT-Dharwad-Paperless-Admin
//
//  Created by Souvik Das on 01/03/21.
//

import Foundation
import FirebaseDatabase



final class AuthManager {
    
    public static let shared = AuthManager()
    
    static func safeEmail(emailAddress: String) -> String{
        var safeEmail = emailAddress.replacingOccurrences(of: "@", with: "(at)")
        safeEmail = safeEmail.replacingOccurrences(of: ".", with: "(dot)")
        return safeEmail
    }
    
    public let database = Database.database().reference()
    
}

extension AuthManager {
    
    public func userExists(with email:String, completion: @escaping((Bool) -> Void)){
        
        var safeEmail = email.replacingOccurrences(of: "@", with: "(at)")
        safeEmail = safeEmail.replacingOccurrences(of: ".", with: "(dot)")
        database.child("users/\(safeEmail)").observeSingleEvent(of: .value, with: {DataSnapshot in
            guard let _ = DataSnapshot.value as? [String: Any] else{
                completion(false)
                return
            }
        })
        completion(true)
    }
    
    public func insertUser(with user: AppUser, completion: @escaping (Bool) -> Void){

        let temp: [String: Any] = [
            "email": user.emailAddress,
            "docStat": user.docStat,
            "link1": user.link1,
            "link2": user.link2,
            "link3": user.link3
        ]
        database.child("users/\(user.safeEmail)/stats").setValue( temp, withCompletionBlock: {error, _ in
            guard error == nil else{
                print("Failed to write DATABASEMANAGER")
                completion(false)
                return
            }
            completion(true)
        })
    }
}
extension AuthManager {
    public func getStat(for email: String, completion: @escaping (Result<[Documents], Error>) -> Void){
        
        database.child("users/\(email)/stats").observe(.value, with: { snapshot in
            print("VALUE \(snapshot.value)")
            guard let value = snapshot.value as? [String: Any] else{
                print("here")
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            guard let docStat = value["docStat"] as? String,
                  let link1 = value["link1"] as? String,
                  let link2 = value["link2"] as? String,
                  let link3 = value["link3"] as? String else {
                return
            }
            let docs: [Documents] = [Documents(stat: docStat, link1: link1, link2: link2, link3: link3)]
            completion(.success(docs))
            
        })
    }
    public func getAll( completion: @escaping (Result<[Admin], Error>) -> Void){
        
        
        database.child("users").observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [String: Any] else{
                print("here")
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            
            var data = [Admin]()
            
            for i in value {
                let baseKey = i.value as? [String: Any]
                let secondaryKey = baseKey!["stats"] as? [String: Any]
                guard let docStat = secondaryKey!["docStat"] as? String,
                      let link1 = secondaryKey!["link1"] as? String,
                      let link2 = secondaryKey!["link2"] as? String,
                      let link3 = secondaryKey!["link3"] as? String,
                      let email = secondaryKey!["email"] as? String
                else {
                    return
                }
                let temp: Admin = Admin(email: email, stat: docStat, link1: link1, link2: link2, link3: link3)
                data.append(temp)
                
            }
            completion(.success(data))
            
        })
    }
    public enum DatabaseError: Error {
        case failedToFetch
        
        public var localizedDescription: String {
            switch self {
            case .failedToFetch:
                return "failed"
            }
        }
    }
}
