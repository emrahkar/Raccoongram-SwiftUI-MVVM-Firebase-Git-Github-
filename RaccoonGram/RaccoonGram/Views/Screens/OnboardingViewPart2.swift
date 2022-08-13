//
//  OnboardingViewPart2.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 2.08.2022.
//

import SwiftUI

struct OnboardingViewPart2: View {
    
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var displayName: String
    @Binding var email: String
    @Binding var providerID: String
    @Binding var provider: String
    @State var showImagePicker: Bool = false
    
    
    //FOr image picket
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var showError: Bool = false
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            Text("What's your name?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.MyTheme.lavenderColor)
            
            TextField("Add your name here...", text: $displayName)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.MyTheme.beigeColor)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
                .padding(.horizontal)
            
            Button {
                showImagePicker.toggle()
            } label: {
                Text("Finish: Add profile picture")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.lavenderColor)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .accentColor(Color.MyTheme.tealColor)
            .opacity(displayName != "" ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 1.0))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.MyTheme.tealColor)
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showImagePicker, onDismiss: createProfile) {
            ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType)
        }
        .alert(isPresented: $showError) {
            return Alert(title: Text("Error creating profile"))
        }
        
    }
    
    //MARK: FUNCTIONS
    
    func createProfile() {
        
        AuthService.instance.createNewUserInDatabase(name: displayName, email: email, providerID: providerID, provider: provider, profileImage: imageSelected) { (returnedUserID) in
            
            if let userID = returnedUserID {
                print("sucessfully created new user in database")
                
                AuthService.instance.logInUserToApp(userID: userID) { success in
                    if success {
                        print("User logged in!")
                        //return to app
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                        
                    } else {
                        print("error logging in")
                        self.showError.toggle()
                    }
                }
                
            } else {
                //error
                print("Error in creating user in database")
            }
        }
        print("Create Profile")
    }
}

struct OnboardingViewPart2_Previews: PreviewProvider {
    
    @State static var testString: String = "Test"
    static var previews: some View {
        OnboardingViewPart2(displayName: $testString, email: $testString, providerID: $testString, provider: $testString)
    }
}
