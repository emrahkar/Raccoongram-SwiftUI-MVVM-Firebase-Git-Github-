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

class AuthService {
    
    //MARK:Properties
    
    static let instance = AuthService()
    
    //MARK: AUTH USER Functions
    
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
}
