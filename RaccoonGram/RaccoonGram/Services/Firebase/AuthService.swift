//
//  AuthService.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 9.08.2022.
//

//used to auth users in firebase
//used to handle user accounts in firebase

import Foundation
import FirebaseAuth
import UIKit
import FirebaseFirestore

let DB_BASE = Firestore.firestore()

class AuthService {
    
    //MARK: Properties
    
    static let instance = AuthService()
    private var REF_USERS = DB_BASE.collection("users")
    
    //MARK: AUTH USER FUNCTIONS
    
    func logInUsertoFirebase(credential: AuthCredential, handler: @escaping (_ providerID: String?, _ isError: Bool) -> ()) {
        
        Auth.auth().signIn(with: credential) { result, error in
            
            //check for errors
            if error != nil {
                print("Error logging in to Firebase")
                handler(nil, true)
                return
            }
            
            //check for provider ID
            guard let providerID = result?.user.uid else {
                print("Error getting prvider ID")
                handler(nil, true)
                return
            }
            
            //sucess connecting to firebase
            handler(providerID, false)
        }
    }
    
    func logInUserToApp(userID: String, handler: @escaping (_ success: Bool) ->()) {
        
        //Get the users info
        getUserInfo(forUserID: userID) { returnedName, returnedBio in
            if let name = returnedName,
               let bio = returnedBio {
                print("Success getting user info while logging in")
                handler(true)
                
                //Set the users info in our app/
            } else{
                print("error getting user infowhile logging in)")
                handler(false)
            }
        }
        //set the users info into our app
    }
    
    func createNewUserInDatabase(name: String, email: String, providerID: String, provider: String, profileImage: UIImage, handler: @escaping (_ userID: String?) ->()) {
        
        //set up a user document with the user collection
        let document = REF_USERS.document()
        let userID = document.documentID
        
        //Upload profile image to Storage
        
        ImageManager.instance.uploadProfileImage(userID: userID, image: profileImage)
        
        
        //upload profile data to Firestore
        let userData: [String: Any] = [
            DatabaseUserField.displayName : name,
            DatabaseUserField.email: email,
            DatabaseUserField.providerID: providerID,
            DatabaseUserField.provider: provider,
            DatabaseUserField.userID: userID,
            DatabaseUserField.bio: "",
            DatabaseUserField.dateCreated: FieldValue.serverTimestamp()
        ]
        
        document.setData(userData) { (error) in
            if let error = error {
                print("Error uploading data to user document \(error)")
                handler(nil)
            } else{
                //Success
                handler(userID)
            }
        }
    }
    
    //MARK: GET USER FUNCTIONS
    
    func getUserInfo(forUserID userID: String, handler: @escaping (_ name: String?, _ bio: String?) ->()) {
        
        REF_USERS.document(userID).getDocument { documentSnapshot, error in
            if let document = documentSnapshot,
               let name = document.get(DatabaseUserField.displayName) as? String,
               let bio = document.get(DatabaseUserField.bio) as? String {
                print("Sucess getting user info")
                handler(name, bio)
                return
            } else {
                print("Error getting user info")
                handler(nil, nil)
                return
            }
        }
    }
}


//FireBase Auth
//            Auth.auth().signIn(with: credential) { result, error in
//
//                isLoading = false
//
//                if let error = error {
//                    print(error.localizedDescription)
//                    return
//                  }
//
//                //Displaying User Name
//
//                guard let user = result?.user else {
//                    return
//                }
//
//                print(user.displayName ?? "Success")
//
//                self.showOnBoardingPart2.toggle()
//
//            }

