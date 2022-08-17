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
    func logInUsertoFirebase(credential: AuthCredential, handler: @escaping (_ providerID: String?, _ isError: Bool, _ isNewUser: Bool?, _ userID: String?) -> ()) {
        Auth.auth().signIn(with: credential) { result, error in
            //check for errors
            if error != nil {
                print("Error logging in to Firebase")
                handler(nil, true, nil, nil)
                return
            }
            //check for provider ID
            guard let providerID = result?.user.uid else {
                print("Error getting prvider ID")
                handler(nil, true, nil, nil)
                return
            }
            
            self.checkIfUserExistsInDatabase(providerID: providerID) { returnedUserID in
                if let userID = returnedUserID {
                    //user exists log in to app
                    handler(providerID, false, false, userID)
                } else {
                    //user do not exist, continue onboarding
                    handler(providerID, false, true, nil)
                }
            }
        }
    }
    
    func logInUserToApp(userID: String, handler: @escaping (_ success: Bool) ->()) {
        //Get the users info
        getUserInfo(forUserID: userID) { returnedName, returnedBio in
            if let name = returnedName,
               let bio = returnedBio {
                print("Success getting user info while logging in")
                handler(true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    //Set the users info in our app/
                    UserDefaults.standard.set(userID, forKey: CurrentUserDefaults.userID)
                    UserDefaults.standard.set(bio, forKey: CurrentUserDefaults.bio)
                    UserDefaults.standard.set(name, forKey: CurrentUserDefaults.displayName)
                }
            } else{
                print("error getting user infowhile logging in)")
                handler(false)
            }
        }
    }
    
    func logOutUser(handler: @escaping (_ success: Bool) ->()) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error \(error)")
            handler(false)
        }
        handler(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let defaultsDictionary = UserDefaults.standard.dictionaryRepresentation()
            defaultsDictionary.keys.forEach { key in
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
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
                return
            }
        }
    }
    
    
    private func checkIfUserExistsInDatabase(providerID: String, handler: @escaping (_ existingUserID: String?) -> ()) {
        
        REF_USERS.whereField(DatabaseUserField.providerID, isEqualTo: providerID).getDocuments { (quarySnapshot, error) in
            
            if let snapShot = quarySnapshot, snapShot.count > 0, let document = snapShot.documents.first {
                //sucess existing user
                let existingUserID = document.documentID
                handler(existingUserID)
            } else {
                //Error, new user
                handler(nil)
                return
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

