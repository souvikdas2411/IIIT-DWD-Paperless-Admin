//
//  User.swift
//  IIIT-Dharwad-Paperless-Admin
//
//  Created by Souvik Das on 01/03/21.
//

import Foundation

struct AppUser{

    let emailAddress : String
    
    var safeEmail : String {
        var safeEmail = emailAddress.replacingOccurrences(of: "@", with: "(at)")
        safeEmail = safeEmail.replacingOccurrences(of: ".", with: "(dot)")
        return safeEmail
    }
    
    var docStat : String {
        var temp = "Not submitted"
        return temp
    }
    
    var link1 : String {
        var temp = "Not submitted"
        return temp
    }
    
    var link2 : String {
        var temp = "Not submitted"
        return temp
    }
    
    var link3 : String {
        var temp = "Not submitted"
        return temp
    }
    
}
