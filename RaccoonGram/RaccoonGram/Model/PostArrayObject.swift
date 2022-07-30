//
//  PostArrayObject.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 29.07.2022.
//

import Foundation


class PostArrayObject: ObservableObject {
    
    @Published var dataArray = [PostModel]()
    
    init() {
        
        print("FETCH FROM DATABASE") //normally we do this
        
        let post1 = PostModel(postID: "", userID: "", username: "Emrah", caption: "This is a caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post2 = PostModel(postID: "", userID: "", username: "Handan", caption: nil, dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post3 = PostModel(postID: "", userID: "", username: "Sami", caption: "hahahhahahahah", dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post4 = PostModel(postID: "", userID: "", username: "Yeliz", caption: nil, dateCreated: Date(), likeCount: 0, likedByUser: false)
        
        self.dataArray.append(post1)
        self.dataArray.append(post2)
        self.dataArray.append(post3)
        self.dataArray.append(post4)
    }
    
    //used for single addition
    
    init(post: PostModel) {
        
        self.dataArray.append(post)
    }
    
   
}
