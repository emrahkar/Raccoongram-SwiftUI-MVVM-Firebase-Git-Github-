//
//  PostModel.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 29.07.2022.
//

import Foundation
import SwiftUI

struct PostModel: Identifiable, Hashable {
    
    var id = UUID()
    var postID: String  //ID for the post in Database
    var userID: String  //ID for the user in Database
    var username: String
    var caption: String?
    var dateCreated: Date
    var likeCount: Int
    var likedByUser: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    
}
