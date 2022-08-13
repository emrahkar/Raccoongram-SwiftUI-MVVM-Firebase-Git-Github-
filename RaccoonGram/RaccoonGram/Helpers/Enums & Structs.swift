//
//  Enums & Structs.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 12.08.2022.
//

import Foundation

struct DatabaseUserField { //field within the user document in database
    
    static let displayName = "display_name"
    static let email = "email"
    static let providerID = "provider_id"
    static let provider = "provider"
    static let userID = "user_id"
    static let bio = "bio"
    static let dateCreated = "date_created"
    
    
}

struct CurrentUserDefaults {
    
    static let displayName = "display_name"
    static let bio = "bio"
    static let userID = "user_id"
    
}
