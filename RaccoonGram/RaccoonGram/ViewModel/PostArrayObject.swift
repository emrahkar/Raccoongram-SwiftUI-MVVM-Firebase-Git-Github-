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
    
    //used for single post selection
    
    init(post: PostModel) {
        
        self.dataArray.append(post)
    }
    
    //USED FOR GETTING POSTS FOR USER PROFILE
    init(userID: String) {
        print("GET POSTS FOR USERID \(userID)")
        
        DataService.instance.dowloadPostForUser(userID: userID) { (returnedPosts) in
          
            let sortedPosts = returnedPosts.sorted { (post1, post2) in
                return post1.dateCreated > post2.dateCreated
            }
            self.dataArray.append(contentsOf: sortedPosts)
           
        }
        
    }
    
    //used for feed
    
    init(shuffled: Bool) {
        
        print("GET POSTS FOR FEED SHUFFLED \(shuffled)")
        DataService.instance.downloadPostsForFeed { (returnedPosts) in
            if shuffled {
                let shuffledPosts = returnedPosts.shuffled()
                self.dataArray.append(contentsOf: shuffledPosts)
            } else {
                self.dataArray.append(contentsOf: returnedPosts)
            }
        }
        
    }
   
}
