//
//  CommentModel.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 29.07.2022.
//

import Foundation

struct CommentModel: Identifiable, Hashable {
    
    var id = UUID()
    var commentID: String //ID for the comment  in Database
    var userID: String //ID for user in database
    var username: String
    var content: String
    var dateCreated: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
