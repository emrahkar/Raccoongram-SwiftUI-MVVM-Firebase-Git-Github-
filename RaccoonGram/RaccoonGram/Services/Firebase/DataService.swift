//
//  DataService.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 16.08.2022.
//

//used to handle upload and download data (other than User) from out database
import Foundation
import SwiftUI
import FirebaseFirestore

class DataService {
    
    static let instance = DataService()
    
    private var REF_POSTS = DB_BASE.collection("posts") //ref to posts collection
    
    //MARK: CREATE FUNCTION
    
    
    func uploadPost(image: UIImage, caption: String?, displayName: String, userID: String, handler: @escaping (_ success:Bool)->()) {
        
        let document = REF_POSTS.document()
        let postID = document.documentID
        
        //upload image to storage
        ImageManager.instance.uploadPostImage(postID: postID, image: image) { (success) in
            if success {
                //succesfully uploaded image data to storage
                // now upload post to database
                let postData:[String:Any] = [
                    DatabasePostField.postID: postID,
                    DatabasePostField.userID: userID,
                    DatabasePostField.displayName: displayName,
                    DatabasePostField.caption: caption,
                    DatabasePostField.dateCreated: FieldValue.serverTimestamp(),
                ]
                
                document.setData(postData) { (error) in
                    if let error = error {
                        print("Uploading data to post document \(error)")
                        handler(false)
                        return
                    } else {
                        //return back to the app
                        handler(true)
                        return
                    }
                }
                
            } else {
                print("Error uploading post image to firebase")
                handler(false)
                return
            }
        }
        
    }
    
    //MARK: GET FUCTIONS
    
    func dowloadPostForUser(userID: String, handler: @escaping(_ posts:[PostModel])->()) {
        
        REF_POSTS.whereField(DatabasePostField.userID, isEqualTo: userID).getDocuments { (querySnapshot, error) in
            
            handler(self.getPostsFromSnapshot(querySnapshot: querySnapshot))
        }
    }
    
    func downloadPostsForFeed(handler: @escaping (_ posts: [PostModel]) ->()) {
        REF_POSTS.order(by: DatabasePostField.dateCreated, descending: true).limit(to: 50).getDocuments { (querySnapshot, error) in
            handler(self.getPostsFromSnapshot(querySnapshot: querySnapshot))
        }
    }
    
    private func getPostsFromSnapshot(querySnapshot: QuerySnapshot?) -> [PostModel] {
        
        var postArray = [PostModel]()
        
        if let snapshot = querySnapshot, snapshot.documents.count > 0 {
            for document in snapshot.documents {
                if
                    let userID = document.get(DatabasePostField.userID) as? String,
                    let displayName = document.get(DatabasePostField.displayName) as? String,
                    let timestamp = document.get(DatabasePostField.dateCreated) as? Timestamp{
                    
                    let caption = document.get(DatabasePostField.caption) as? String
                    let date = timestamp.dateValue()
                    let postID = document.documentID
                    
                    let newPost = PostModel(postID: postID, userID: userID, username: displayName,caption: caption, dateCreated: date, likeCount: 0, likedByUser: false)
                    postArray.append(newPost)
                }
                    
            }
            return postArray
        } else {
            print("No documents in snapshot found for this user")
            return postArray
        }
        
    }
    
}
